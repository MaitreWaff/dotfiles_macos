#!/usr/bin/env zsh

echo "\n<<< Starting ZSH Setup >>>\n"

# Installation unnecessary; it's in the Brewfile.

echo "Enter superuser (sudo) password to edit /etc/shells"
echo '/usr/local/bin/zsh' | sudo tee -a '/etc/shells' > /dev/null

chsh -s '/usr/local/bin/zsh'

ln -s /usr/local/bin/zsh /private/var/select/sh

echo "\n<<< ZSH Setup Done!!!. >>>\n"
