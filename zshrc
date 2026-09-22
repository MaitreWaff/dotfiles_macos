# ─── Variables d'environnement ────────────────────────────────────────────────
export HOMEBREW_CASK_OPTS="--no-quarantine"
export NULLCMD=bat                    # commande par défaut pour redirection vide
export N_PREFIX="$HOME/.n"           # répertoire d'installation de n (Node manager)
export PREFIX="$N_PREFIX"
export VAGRANT_DEFAULT_PROVIDER=qemu  # provider Vagrant par défaut
export PIPX_HOME="$HOME/.local/pipx"
export PIPX_BIN_DIR="$HOME/.local/bin"

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
  "$HOME/bin"
  "$N_PREFIX/bin"
  $path
  "$HOME/.local/bin"
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

# Argcomplete pour exegol — chargé uniquement si register-python-argcomplete est disponible
command -v register-python-argcomplete &>/dev/null \
  && eval "$(register-python-argcomplete --no-defaults exegol)"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/maitrewaff/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
