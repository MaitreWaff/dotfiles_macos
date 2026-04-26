#!/usr/bin/env zsh

set -euo pipefail

echo "\n<<< Configuration de Node.js... >>>\n"

# n est installé via Homebrew (Brewfile)
# N_PREFIX et PATH sont définis dans zshrc

if exists node; then
  echo "Node $(node --version) & NPM $(npm --version) déjà installés"
else
  echo "Installation de Node (latest + LTS) via n..."
  n latest
  n lts
fi

echo "Installation des paquets npm globaux..."

npm install --global \
  firebase-tools \
  @angular/cli \
  @ionic/cli \
  typescript \
  json-server \
  http-server \
  trash-cli \
  yarn

echo "\nPaquets npm globaux installés :"
npm list --global --depth=0

echo "\n<<< Node Setup terminé. >>>\n"
