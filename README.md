# dotfiles macOS

Configuration personnelle pour macOS, gérée avec [Dotbot](https://github.com/anishathalye/dotbot).  
Trois profils Homebrew pour s'adapter à chaque contexte : minimal, développement complet, pentest.

---

## Prérequis

- macOS 13 Ventura ou supérieur
- Connexion Internet (Homebrew + packages)

### Xcode Command Line Tools

Requis avant toute installation. Si absent, Homebrew et git refuseront de démarrer.

```bash
xcode-select --install
```

### Licence Xcode (profil dev uniquement)

Le profil `dev` installe Xcode depuis le Mac App Store via `mas`. Après installation, Xcode exige que sa licence soit acceptée — sans ça, `git` affiche une erreur et certains outils de compilation refusent de fonctionner.

Accepter la licence **avant** de relancer le profil :

```bash
sudo xcodebuild -license accept
```

> Si Xcode n'est pas encore installé au moment de l'exécution de `brew bundle`, `mas` l'installe automatiquement — mais il faudra accepter la licence manuellement une fois l'installation terminée, puis relancer `./install-profile dev` si des étapes ont échoué entre-temps.

---

## Installation

### Cloner le repo

```bash
git clone git@github.com:MaitreWaff/dotfiles_macos.git ~/.dotfiles
cd ~/.dotfiles
git submodule update --init --recursive
```

### Choisir un profil

```bash
./install-profile dev       # machine de dev principale (recommandé)
./install-profile minimal   # machine légère, VM, setup express
./install-profile pentest   # outils pentest (add-on, après dev)
```

Chaque profil enchaîne automatiquement les étapes nécessaires :

| Étape | minimal | dev | pentest |
|---|:---:|:---:|:---:|
| Symlinks dotfiles | ✅ | ✅ | — |
| zsh par défaut | ✅ | ✅ | — |
| Homebrew + paquets | Brewfile.minimal | Brewfile | Brewfile.pentest |
| Node.js + npm globals | — | ✅ | — |

> **Note :** `./install` seul ne fait que les symlinks (Dotbot). Utilise `./install-profile` pour un setup complet.

### Désinstaller un profil

Chaque profil dispose de son script de désinstallation dédié, qui ne touche
qu'aux paquets Homebrew (formules, casks, taps, extensions VS Code, apps Mac
App Store) — jamais aux symlinks Dotbot ni au shell par défaut.

```bash
./uninstall-minimal   # retire les paquets de Brewfile.minimal
./uninstall-dev       # retire les paquets de Brewfile
./uninstall-pentest   # retire les paquets de Brewfile.pentest
```

Chaque script :
- lit dynamiquement le Brewfile correspondant (jamais de liste codée en dur —
  toujours synchronisé avec le contenu réel du fichier) ;
- ignore silencieusement ce qui n'est pas installé ;
- demande une confirmation `[y/N]` avant toute suppression ;
- accepte `--zap` pour aussi purger préférences/caches/données des casks ;
- fournit une aide complète via `--help`.

> ⚠️ **Recoupement des profils** : `Brewfile` (dev) duplique intégralement
> `Brewfile.minimal` (mêmes formules/casks/extensions, pas de dépendance
> entre les deux fichiers). `./uninstall-dev` et `./uninstall-minimal`
> agissent donc chacun sur leur fichier — si les deux profils sont installés
> en même temps, désinstaller l'un supprime aussi ce qu'il partage avec
> l'autre. `Brewfile.pentest`, en revanche, ne recoupe ni dev ni minimal :
> `./uninstall-pentest` est totalement indépendant.

---

## Profils Brewfile

Trois profils indépendants, à choisir selon la machine.

### Profil minimal — Machine légère ou secondaire

Idéal pour : vieux Mac, VM, machine de prêt, setup express.  
Philosophie : uniquement l'essentiel, rien de lourd.

```bash
./install-profile minimal
# ou, pour Homebrew seul :
brew bundle --file=Brewfile.minimal
```

#### CLI

| Outil | Description |
|---|---|
| `bat` | Remplacement de `cat` avec coloration syntaxique |
| `bat-extras` | Scripts intégrant bat (`batgrep`, `batman`, `batdiff`…) |
| `curl` | Transferts HTTP/HTTPS/FTP |
| `eza` | Remplacement moderne de `ls` (icônes, couleurs, git) |
| `git` | Gestionnaire de versions |
| `gitleaks` | Scan de secrets dans les dépôts git |
| `gnupg` | Chiffrement et signatures GPG |
| `less` | Paginateur de texte |
| `nano` | Éditeur texte léger |
| `shellcheck` | Linter statique pour scripts shell/bash |
| `tmux` | Multiplexeur de terminal |
| `wget` | Téléchargeur HTTP |
| `zsh` | Shell recommandé |

#### Apps GUI

| App | Description |
|---|---|
| AppCleaner | Désinstalleur propre |
| Firefox | Navigateur web |
| Git Credential Manager | Gestion centralisée des credentials git |
| iTerm2 | Terminal avancé |
| MonitorControl | Contrôle luminosité/volume des écrans externes |
| The Unarchiver | Extraction d'archives (zip, rar, 7z, tar…) |
| Visual Studio Code | Éditeur de code |
| VLC | Lecteur multimédia universel |

#### VS Code (16 extensions essentielles)

| Extension | Description |
|---|---|
| GitLens | Blame, historique et annotations git inline |
| Git Graph | Visualisation graphique de l'arbre git |
| Prettier | Formatage automatique multi-langages |
| ESLint | Linting JavaScript/TypeScript |
| Error Lens | Erreurs affichées directement sur la ligne |
| Pretty TS Errors | Erreurs TypeScript lisibles |
| Material Icon Theme | Icônes de fichiers Material Design |
| EditorConfig | Respect des règles `.editorconfig` |
| Path IntelliSense | Autocomplétion des chemins de fichiers |
| Better Comments | Commentaires colorés par type (TODO, !, ?) |
| Auto Close Tag | Fermeture automatique des balises HTML/XML |
| Auto Rename Tag | Renommage simultané balise ouvrante/fermante |
| Indent Rainbow | Colorisation des niveaux d'indentation |
| Code Spell Checker | Correcteur orthographique en temps réel |
| YAML | Support YAML avec validation de schémas |
| GitHub Theme | Thème GitHub officiel (dark/light) |

#### Désinstallation propre

`./uninstall-minimal` retire les formules, casks, extensions VS Code et apps
Mac App Store listés dans `Brewfile.minimal` (parsing dynamique du fichier,
comme à l'installation).

```bash
./uninstall-minimal          # désinstallation standard
./uninstall-minimal --zap    # + suppression préférences/caches des casks
./uninstall-minimal --help   # détail complet (comportement, avertissements)
```

> ⚠️ Le profil dev duplique intégralement les paquets du profil minimal
> (même formules/casks/extensions). Si dev est aussi installé, ce script
> supprimera également les outils qu'il partage avec minimal. Voir `--help`.

---

### Profil dev — Développement complet

Inclut tout le profil minimal + outils dev, DevOps, cloud, IA.  
Les outils de pentest sont dans `Brewfile.pentest` (opt-in séparé).

```bash
./install-profile dev
# ou, pour Homebrew seul :
brew bundle --file=Brewfile
```

#### CLI ajoutés (par rapport au minimal)

| Catégorie | Outils |
|---|---|
| **Langages & runtimes** | `go`, `node`, `n` (Node version manager), `python@3.13`, `pipx` |
| **DevOps & conteneurs** | `ansible`, `docker`, `kompose`, `kubernetes-cli`, `minikube`, `qemu`, `libvirt`, `socket_vmnet` |
| **Infrastructure as Code** | `terraform` (HashiCorp), `pulumi` |
| **Web & réseau** | `httpie`, `pnpm` |
| **Bases de données** | `postgresql@14` |
| **Documents & médias** | `pandoc`, `poppler`, `exiftool` |
| **Générateur de site** | `hugo` |
| **Utilitaires** | `asciinema`, `fortune`, `cowsay`, `telnet`, `ungit`, `watchman`, `git-flow`, `fontconfig` |

#### Apps GUI ajoutées

| Catégorie | Apps |
|---|---|
| **Navigateurs** | Arc, Brave, Google Chrome |
| **Développement** | Docker Desktop, GitHub Desktop, GitKraken, Postman, Sublime Text, DB Browser SQLite, Expo Orbit, Hex Fiend, ngrok |
| **IA & assistants** | Claude, Claude Code, ChatGPT |
| **Productivité** | Notion, Notion Calendar, Notion Mail, Obsidian, MacDown, TeXMaker, Alfred, Keyboard Maestro |
| **Communication** | Discord, Microsoft Teams |
| **Cloud & stockage** | Dropbox, Google Drive |
| **Virtualisation** | UTM, Vagrant, VirtualBox, Windows App |
| **Utilitaires** | LibreOffice, Adobe Acrobat Reader, Tella, Royal TSX |

#### Mac App Store

| App | Usage |
|---|---|
| Xcode | IDE Apple — requis pour iOS/macOS dev |
| Developer | App développeur Apple officielle |
| CmdRef | Cheatsheets de commandes |
| Data Jar | Stockage de données pour Raccourcis Siri |
| Jayson | Viewer/éditeur JSON interactif |
| SysNetInfo | Informations système et réseau |
| OX Drive | Client Open-Xchange |
| Kindle | Liseuse |
| Quick Note | Notes rapides depuis la barre de menu |
| Stockfish | Moteur d'échecs open source |
| Capacities | Extension web Capacities |

#### VS Code — aperçu par catégorie (184 extensions)

| Catégorie | Nb | Exemples |
|---|---|---|
| TypeScript / JavaScript | 16 | TS Error Translator, ES7 snippets, Next.js snippets |
| Python | 9 | Pylance, Debugpy, AutoDocstring |
| Go | 1 | Go officiel |
| Rust | 1 | rust-analyzer |
| C/C++ | 6 | cpptools, CMake Tools |
| Web (HTML/CSS/Tailwind) | 7 | Tailwind CSS IntelliSense, Live Server |
| Vue / Angular / Astro | 4 | Volar, Angular Console, Astro |
| Markdown | 14 | Markdown All in One, Marp, markmap |
| YAML / TOML / JSON | 5 | YAML RedHat, Even Better TOML |
| Conteneurs & DevOps | 11 | Docker, Remote SSH, Remote Containers |
| Infrastructure as Code | 7 | Terraform HashiCorp, CloudFormation snippets |
| AWS | 14 | AWS Toolkit, Amazon Q, Boto3 IDE |
| Base de données | 2 | SQLite Viewer |
| Test & qualité | 4 | Jest Runner, SonarLint |
| API & HTTP | 4 | REST Client, Thunder Client, Postman |
| Jupyter & data science | 5 | Jupyter, renderers, cell tags |
| Git avancé | 6 | Git History, GitHub Codespaces |
| IA & assistance | 6 | Claude Code, Ollama Autocoder |
| Diagrammes | 3 | Draw.io, Excalidraw |
| Productivité & UI | ~30 | Bookmarks, Peacock, QuokkaJS |

#### Désinstallation propre

`./uninstall-dev` retire les formules, casks, extensions VS Code, apps Mac
App Store et taps listés dans `Brewfile` (parsing dynamique du fichier,
comme à l'installation).

```bash
./uninstall-dev          # désinstallation standard
./uninstall-dev --zap    # + suppression préférences/caches des casks
./uninstall-dev --help   # détail complet (comportement, avertissements)
```

> ⚠️ Brewfile (dev) inclut déjà toutes les entrées de Brewfile.minimal
> (dupliquées, pas référencées). Ce script supprime donc aussi les outils
> du profil minimal. Le profil pentest n'est jamais concerné (aucun
> recoupement) — voir `--help` pour le détail.

---

### Profil pentest — Sécurité offensive

> ⚠️ À utiliser uniquement dans un cadre légal : audits autorisés, CTF, bug bounty, lab personnel.

À installer **en complément** du profil dev :

```bash
./install-profile dev                # profil dev d'abord
./install-profile pentest            # puis pentest par-dessus
# ou, pour Homebrew seul :
brew bundle --file=Brewfile.pentest
```

#### Désinstallation propre

`./uninstall-pentest` retire uniquement les formules, casks et taps listés dans
`Brewfile.pentest` (parsing dynamique du fichier) — les profils minimal et dev
ne sont jamais touchés.

```bash
./uninstall-pentest          # désinstallation standard
./uninstall-pentest --zap    # + suppression préférences/caches des casks (captures, projets…)
```

#### Réseau & scan

| Outil | Description |
|---|---|
| `nmap` | Scanner de ports, services et OS |
| `aircrack-ng` | Audit Wi-Fi (WEP/WPA, injection de paquets) |
| `arp-scan` | Scanner ARP et fingerprinting réseau local |
| `netcat` | Couteau suisse TCP/UDP (écoute, transfert, reverse shells) |
| `openvpn` | Client VPN SSL/TLS (pivoting, tunnels) |
| `wireshark` | Analyseur de protocoles réseau (CLI : `tshark`) |
| `netdiscover` | Découverte active/passive d'hôtes réseau (tap sidaf) |

#### Reconnaissance & OSINT web

| Outil | Description |
|---|---|
| `ffuf` | Fuzzer web rapide (répertoires, paramètres, vhosts) |
| `feroxbuster` | Découverte de contenu web récursif (Rust) |
| `gobuster` | Brute-force DNS/répertoires/vhosts (Go) |
| `nikto` | Scanner de vulnérabilités de serveurs web |
| `sqlmap` | Détection et exploitation d'injections SQL |
| `httrack` | Copie de sites web pour analyse offline |
| `wpscan` | Scanner de vulnérabilités WordPress (tap wpscanteam) |

#### Exploitation & post-exploitation

| Outil | Description |
|---|---|
| `hydra` | Cracker de credentials réseau (SSH, FTP, HTTP, SMB…) |
| `john` | John the Ripper — casseur de hashes multi-formats |
| `hashcat` | Casseur de hashes GPU (le plus rapide) |
| `exploitdb` | Base Exploit-DB locale (`searchsploit`) |
| `yara` | Identification de malwares par règles |
| `ridenum` | Énumération RID/utilisateurs Windows via SMB (tap sidaf) |

#### Apps GUI

| App | Description |
|---|---|
| Burp Suite | Proxy d'interception web et suite de test (PortSwigger) |
| Wireshark App | Interface graphique Wireshark |
| qFlipper | Companion app Flipper Zero (RFID, IR, radio) |

---

## Structure du projet

```
~/.dotfiles/
├── README.md                  ← Ce fichier
├── LICENSE                    ← MIT
├── install-profile            ← Point d'entrée principal (minimal|dev|pentest)
├── install                    ← Symlinks uniquement (Dotbot)
├── install.conf.yaml          ← Configuration Dotbot (symlinks, répertoires)
│
├── uninstall-minimal          ← Désinstalle les paquets de Brewfile.minimal
├── uninstall-dev              ← Désinstalle les paquets de Brewfile
├── uninstall-pentest          ← Désinstalle les paquets de Brewfile.pentest
├── uninstall-lib.sh           ← Fonctions partagées par les 3 scripts uninstall-* (à sourcer)
│
├── Brewfile.minimal           ← Profil léger (CLI essentiels + apps de base)
├── Brewfile                   ← Profil normal (dev complet — installé par défaut)
├── Brewfile.pentest           ← Profil sécurité (opt-in, à lancer manuellement)
│
├── zshrc                      ← Configuration interactive zsh (aliases, prompt, PATH)
├── zshenv                     ← Variables d'environnement zsh (chargé avant zshrc)
├── bashrc                     ← Configuration bash (Android SDK, argcomplete)
├── gitconfig                  ← Configuration git globale (user, credential helper)
├── gitignore_global           ← Gitignore global (.claude/, .DS_Store, secrets…)
├── vimrc                      ← Configuration Vim (syntaxe, tabs, numéros de ligne)
├── tmux.conf                  ← Configuration tmux (préfixe C-j, souris)
│
├── config/
│   └── bat/config             ← Mappings syntaxe bat (zshrc, Brewfile…)
│
├── setup_homebrew.zsh         ← Installe Homebrew + brew bundle (profil en argument)
├── setup_zsh.zsh              ← Configure zsh comme shell par défaut
├── setup_node.zsh             ← Installe Node LTS et packages npm globaux
├── shebang.zsh                ← Script de diagnostic (version zsh, shell info)
│
├── .github/
│   └── workflows/
│       └── security-secrets.yml  ← CI : scan Gitleaks (push + hebdomadaire)
├── .gitleaks.toml             ← Config Gitleaks (allowlists, chemins ignorés)
│
└── dotbot/                    ← Submodule Dotbot v1.24.1 (gestionnaire symlinks)
```

---

## Mise à jour

### Ajouter un paquet

1. Éditer le Brewfile correspondant
2. `brew bundle --file=<Brewfile>`
3. Committer le changement

### Mettre à jour tous les paquets

```bash
brew update && brew upgrade && brew cleanup
```

### Ré-appliquer les symlinks

```bash
cd ~/.dotfiles && ./install   # symlinks uniquement
```

### Relancer un profil complet

```bash
cd ~/.dotfiles && ./install-profile dev
```

### Mettre à jour le submodule Dotbot

```bash
cd ~/.dotfiles/dotbot
git fetch --tags
git checkout vX.Y.Z         # nouvelle release taguée
cd ..
git add dotbot .gitmodules
git commit -m "fix(security): bumper Dotbot à vX.Y.Z"
```

---

## CI/CD

Un workflow GitHub Actions s'exécute sur chaque push, chaque PR et chaque lundi à 6h UTC :

- **Gitleaks v8.30.1** — scan de l'historique git complet toutes branches
- Vérification SHA256 du binaire (protection supply chain)
- Rapport JSON uploadé en artifact si secrets détectés

Voir `.github/workflows/security-secrets.yml` et `.gitleaks.toml`.

---

## Licence

MIT — voir [LICENSE](LICENSE)
