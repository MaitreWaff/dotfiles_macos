#!/usr/bin/env zsh

set -euo pipefail

if exists brew; then
  echo "\n<<< Homebrew déjà installé, passage au bundle... >>>\n"
else
  echo "\n<<< Homebrew introuvable, installation... >>>\n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "\n<<< Installation des paquets Homebrew (profil normal)... >>>\n"

brew bundle --file=Brewfile --verbose

echo "\n<<< Homebrew Setup terminé. >>>\n"
