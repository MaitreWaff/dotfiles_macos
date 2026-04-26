#!/usr/bin/env zsh

set -euo pipefail

echo "\n<<< Configuration de zsh comme shell par défaut... >>>\n"

ZSH_PATH='/opt/homebrew/bin/zsh'

# Ajouter zsh Homebrew à /etc/shells s'il n'y est pas déjà
if grep -Fxq "$ZSH_PATH" '/etc/shells'; then
  echo "$ZSH_PATH déjà présent dans /etc/shells"
else
  echo "Ajout de $ZSH_PATH dans /etc/shells (mot de passe sudo requis)"
  echo "$ZSH_PATH" | sudo tee -a '/etc/shells' > /dev/null
fi

# Définir zsh Homebrew comme shell par défaut
if [ "$SHELL" = "$ZSH_PATH" ]; then
  echo "Shell par défaut déjà configuré sur $ZSH_PATH"
else
  echo "Changement du shell par défaut vers $ZSH_PATH (mot de passe sudo requis)"
  chsh -s "$ZSH_PATH"
fi

# Symlinker sh → zsh pour la compatibilité
if sh --version | grep -q zsh; then
  echo '/private/var/select/sh déjà lié à zsh'
else
  echo "Symlink de sh → zsh (mot de passe sudo requis)"
  sudo ln -sfv /bin/zsh /private/var/select/sh
fi

echo "\n<<< ZSH Setup terminé. >>>\n"
