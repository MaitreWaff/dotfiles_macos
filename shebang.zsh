#!/usr/bin/env zsh

set -euo pipefail

# Script de diagnostic — version zsh et environnement de base
echo "ZSH_VERSION = $ZSH_VERSION"
echo "Shell courant : $(ps $$ -ocomm=)"
echo "HOME = $HOME"
