#!/usr/bin/env zsh

if exists brew; then
  echo "brew exists, skipping the install..."
else
  echo "brew doesn't exist, installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

fi

echo "\n<<< Starting Homebrew Setup >>>\n"

brew bundle --verbose

echo "\n<<< Homebrew Setup Done!!!. >>>\n"
