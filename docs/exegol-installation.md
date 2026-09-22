# Installation Exegol (Community) sur macOS — procédure & correctifs

> Rédigé après une session de dépannage réelle (macOS, Docker Desktop 4.86.0, Exegol
> Community v5.1.11, Apple Silicon). Objectif : reproduire une installation propre
> et éviter de retomber dans les mêmes pièges.

---

## 0. Prérequis

- macOS avec **Docker Desktop** installé et lancé
- **pipx** installé (`brew install pipx`)
- Un fichier VPN `.ovpn` ou `.conf` si tu comptes te connecter à un lab (HTB, etc.)

---

## 1. Installer Exegol via pipx

Par défaut, `pipx` installe les venvs sous `~/Library/Application Support/pipx/venvs/`.
**Ce chemin pose problème avec Docker Desktop sur macOS** (voir §3) — autant l'éviter
dès le départ.

```bash
# Rediriger pipx vers un chemin sous /Users (déjà partagé par défaut avec Docker Desktop)
export PIPX_HOME="$HOME/.local/pipx"
export PIPX_BIN_DIR="$HOME/.local/bin"

# Rendre permanent (à ajouter dans ~/.zshrc)
cat >> ~/.zshrc <<'EOF'
export PIPX_HOME="$HOME/.local/pipx"
export PIPX_BIN_DIR="$HOME/.local/bin"
EOF
source ~/.zshrc

pipx install exegol
```

---

## 2. Premier lancement

```bash
exegol start pwnbox --vpn ./workspace/vpn/MonLab.ovpn
```

### Erreur rencontrée

```
[-] Bind volume from /Users/.../pipx/venvs/exegol/.../spawn.sh is not possible,
    Docker Desktop configuration is incorrect.
[!] You need to modify the Docker Desktop config and add this path (or the root
    directory) in Docker Desktop > Preferences > Resources > File Sharing configuration.
[*] Exiting...
```

---

## 3. Pistes explorées (dans l'ordre, pour référence)

Ces étapes **n'ont pas suffi seules** mais sont de bonnes pratiques à garder :

### 3.1 Ajouter le chemin dans Docker Desktop → File Sharing
`Docker Desktop > Settings > Resources > File Sharing > +`
**Symptôme observé** : le chemin ajouté disparaît de la liste dès qu'on clique sur
*Apply*. Reproduit aussi bien pour des chemins profonds
(`~/Library/Application Support/pipx/...`) que pour des chemins simples
(`/Users/<user>`).

### 3.2 Vérifier que le chemin n'est pas un lien symbolique cassé
```bash
ls -la "<chemin>"
readlink -f "<chemin>"
```
→ Dans notre cas, le chemin était valide, pas de symlink. Cette piste est à garder
pour d'autres environnements (pyenv, homebrew python) où les venvs pointent parfois
vers un volume externe non partagé.

### 3.3 Accorder Full Disk Access à Docker Desktop
`Réglages Système > Confidentialité et sécurité > Accès complet au disque` → cocher
Docker Desktop, redémarrer Docker Desktop entièrement.
→ **N'a pas résolu le problème seul**, mais reste une bonne pratique générale pour
Docker Desktop sur macOS (accès à `~/Library/Application Support`, etc. protégés
par TCC).

### 3.4 Déplacer l'installation pipx hors d'`Application Support`
Voir §1 (`PIPX_HOME=$HOME/.local/pipx`). Le nouveau chemin
(`/Users/<user>/.local/pipx/...`) est bien sous `/Users`, partagé par défaut par
Docker Desktop.
→ **N'a pas suffi non plus** : l'erreur persistait malgré un chemin théoriquement
déjà couvert par le partage par défaut. C'est ce qui a mené à creuser la vraie
cause (§4).

---

## 4. Cause réelle : bug de compatibilité Exegol / Docker Desktop ≥ 4.4x

### Diagnostic

Exegol détermine les répertoires partagés par Docker Desktop en lisant directement
son fichier de configuration sur disque :

```python
# exegol/config/EnvInfo.py — getDockerDesktopSettings()
file_path = (dir_path / "settings-store.json") if (dir_path / "settings-store.json").is_file() \
            else (dir_path / "settings.json")
...

# getDockerDesktopResources()
docker_desktop_resources = settings.get('FilesharingDirectories',
                                         settings.get('filesharingDirectories', []))
```

Fichier lu : `~/Library/Group Containers/group.com.docker/settings-store.json`

**Problème** : depuis Docker Desktop 4.4x+ (confirmé sur 4.86.0), ce fichier ne
contient plus la clé `FilesharingDirectories` / `filesharingDirectories` — il ne
contient plus que des flags applicatifs génériques (`AutoStart`,
`DisplayedOnboarding`, `SettingsVersion`, etc.). La liste réelle des dossiers
partagés (`vm.fileSharing`) est désormais gérée par le **backend runtime** de
Docker Desktop et exposée uniquement via son socket IPC local :

```bash
curl -s --unix-socket ~/Library/Containers/com.docker.docker/Data/backend.sock \
  http://localhost/app/settings/gui | python3 -m json.tool | grep -A20 '"vm.fileSharing"'
```

Résultat (exemple) :
```json
"vm.fileSharing": [
  {"cached": false, "path": "/Users"},
  {"cached": false, "path": "/Volumes"},
  {"cached": false, "path": "/private"},
  {"cached": false, "path": "/tmp"},
  {"cached": false, "path": "/var/folders"}
]
```

**Conséquence** : `getDockerDesktopResources()` renvoie systématiquement une liste
vide `[]`, donc **aucun chemin ne peut jamais matcher**, quelle que soit la
configuration réelle de Docker Desktop. Le message d'erreur d'Exegol est donc un
**faux négatif permanent** sur les versions récentes de Docker Desktop — inutile de
s'acharner sur la configuration de partage elle-même.

> Remarque annexe : la disparition du chemin ajouté dans l'UI Docker Desktop
> (§3.1) semble être un bug distinct de Docker Desktop 4.86 lui-même (confirmé en
> reproduisant l'ajout directement via l'API du socket `backend.sock` — la nouvelle
> entrée n'est pas non plus persistée côté backend). Les 5 chemins par défaut
> (`/Users`, `/Volumes`, `/private`, `/tmp`, `/var/folders`) restent cependant actifs
> et couvrent la grande majorité des usages courants.

### Correctif appliqué (contournement local)

Patch dans le fichier installé par pipx :
`~/.local/pipx/venvs/exegol/lib/python3.14/site-packages/exegol/config/EnvInfo.py`

```python
@classmethod
def getDockerDesktopResources(cls) -> List[str]:
    settings = cls.getDockerDesktopSettings()
    # Handle legacy settings key
    docker_desktop_resources = settings.get('FilesharingDirectories', settings.get('filesharingDirectories', []))
    if not docker_desktop_resources:
        # Docker Desktop >= 4.4x moved file sharing config out of settings-store.json
        # (it's now only exposed via the backend IPC socket). Fall back to the
        # macOS default whitelist so the check doesn't always fail on modern versions.
        docker_desktop_resources = ["/Users", "/Volumes", "/private", "/tmp", "/var/folders"]
    logger.debug(f"Docker Desktop resources whitelist: {docker_desktop_resources}")
    return docker_desktop_resources
```

### ⚠️ Limite du correctif

Ce patch modifie un fichier du package **installé** (site-packages) : il sera
**écrasé au prochain `pipx upgrade exegol`**. Il faudra soit :
- le réappliquer manuellement après chaque mise à jour d'Exegol,
- ou vérifier si une version plus récente d'Exegol corrige nativement ce problème
  (à vérifier sur le repo GitHub officiel avant de réappliquer),
- ou signaler le bug en amont (issue GitHub Exegol) — **à faire, voir TODO ci-dessous**.

---

## 5. Lancement du conteneur (config finale validée)

Avec interface graphique + logging complet de la session :

```bash
exegol start pwnbox --vpn ./workspace/vpn/MonLab.ovpn --desktop -l
```

| Option | Effet |
|---|---|
| `--desktop` | Active un bureau graphique dans le conteneur (HTTP/noVNC par défaut sur `127.0.0.1:<port aléatoire>`) |
| `--desktop-config vnc:127.0.0.1:5900` | Force le mode VNC sur un port fixe (utilisable avec un client VNC natif type Screen Sharing.app) |
| `-l` / `--log` | Active l'enregistrement complet de la session (commandes + sorties) dans `/workspace/logs/`, format `asciinema` par défaut |
| `--log-method script` | Bascule le format de log en texte brut au lieu d'asciinema |
| `--log-compress` | Compresse automatiquement les fichiers de log |

### Accéder à l'interface graphique

```bash
exegol info pwnbox -v
```
→ affiche l'URL/port d'accès et le mot de passe généré pour la session graphique.
Ouvrir l'URL affichée dans un navigateur (mode HTTP/noVNC), ou se connecter avec un
client VNC si `--desktop-config vnc:...` a été utilisé.

---

## 6. Checklist de dépannage rapide (pour la prochaine fois)

1. `pipx` doit installer sous `$HOME/.local/pipx` (pas `Application Support`) →
   définir `PIPX_HOME` / `PIPX_BIN_DIR` **avant** l'install.
2. Si erreur "Bind volume ... Docker Desktop configuration is incorrect" persiste
   malgré un chemin sous `/Users` : **ne pas s'acharner sur l'UI Docker Desktop**,
   c'est probablement le bug de parsing décrit en §4. Vérifier la version d'Exegol
   installée et la présence du correctif.
3. Pour diagnostiquer la vraie liste de partage Docker Desktop en direct (fiable,
   contourne les bugs de fichiers de config obsolètes) :
   ```bash
   curl -s --unix-socket ~/Library/Containers/com.docker.docker/Data/backend.sock \
     http://localhost/app/settings/gui | python3 -m json.tool | grep -A20 '"vm.fileSharing"'
   ```
4. Toujours donner **Full Disk Access** à Docker Desktop sur macOS (Réglages
   Système > Confidentialité et sécurité) — nécessaire dès qu'un chemin protégé par
   TCC (`~/Library/...`) est impliqué, même si ce n'était pas la cause racine ici.

---

## 7. TODO

- [ ] Ouvrir une issue sur le repo GitHub officiel d'Exegol : le parsing de
      `settings-store.json` (clé `FilesharingDirectories`) est obsolète depuis
      Docker Desktop ≥ 4.4x, qui expose désormais `vm.fileSharing` uniquement via
      le socket IPC backend. Proposer soit de lire ce socket, soit d'ajouter un
      fallback comme celui appliqué en §4.
