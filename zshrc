# ─── Variables d'environnement ────────────────────────────────────────────────
export HOMEBREW_CASK_OPTS="--no-quarantine"
export NULLCMD=bat                    # commande par défaut pour redirection vide
export N_PREFIX="$HOME/.n"           # répertoire d'installation de n (Node manager)
export PREFIX="$N_PREFIX"
export VAGRANT_DEFAULT_PROVIDER=qemu  # provider Vagrant par défaut

# ─── Aliases — navigation & shell ─────────────────────────────────────────────
alias ls='eza -lah --git'       # ls moderne avec métadonnées git
alias exa='eza -lah --git'      # compatibilité muscle memory (ancien nom)
alias cat='bat'                 # cat avec coloration syntaxique
alias bbd='brew bundle dump --force --describe'
alias trail='<<<${(F)path}'     # affiche le PATH ligne par ligne
alias rm=trash                  # déplace vers la corbeille plutôt que supprimer
alias man=batman                # pages man avec bat (coloration + pagination)

# ─── Aliases — Kubernetes ─────────────────────────────────────────────────────
alias k='kubectl'
alias kf='kubectl port-forward'
alias knode='kubectl get node -l'

# ─── Prompt ───────────────────────────────────────────────────────────────────
PROMPT='
%1~ %L %# '
RPROMPT='%*'

# ─── PATH ─────────────────────────────────────────────────────────────────────
# typeset -U élimine automatiquement les doublons
typeset -U path

path=(
  "$N_PREFIX/bin"
  $path
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
)

# ─── Fonctions ────────────────────────────────────────────────────────────────
function mkcd() {
  mkdir -p "$@" && cd "$_"
}

# ─── Completions ──────────────────────────────────────────────────────────────
# Le fpath doit être étendu AVANT l'appel à compinit
fpath=("$HOME/.docker/completions" $fpath)
autoload -Uz compinit && compinit

# Argcomplete pour exegol — chargé uniquement si exegol est installé
command -v exegol &>/dev/null && eval "$(register-python-argcomplete --no-defaults exegol)"
