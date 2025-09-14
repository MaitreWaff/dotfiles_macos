#!/usr/bin/env zsh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "\n<<< Starting Homebrew Setup >>>\n"

brew bundle --verbose

echo "\n<<< Homebrew Setup Done!!!. >>>\n"
