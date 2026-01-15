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


echo "\n<<< Node Setup Done!!!. >>>\n"
