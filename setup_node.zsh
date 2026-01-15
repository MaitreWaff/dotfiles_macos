#!/usr/bin/env zsh

echo "\n<<< Starting Node Setup >>>\n"

# Installation unnecessary; it's in the Brewfile.
# See zshrc for N_PREFIX variable and addition to PATH

if exists node; then
  echo "Node $(node --version) & NPM $(npm --version) already installed"
else
  echo "Installing Node & NPM with n..."
  n latest
  n lts
fi

# Installing Global NPM Packages
npm install --global firebase-tools
npm install --global @angular/cli
npm install --global @ionic/cli
npm install --global typescript
npm install --global json-server
npm install --global http-server
npm install --global trash-cli
npm install --global yarn

echo "Global NPM Packages Installed:"
npm list --global --depth=0

echo "\n<<< Node Setup Done!!!. >>>\n"
