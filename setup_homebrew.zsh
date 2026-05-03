#!/usr/bin/env zsh

set -euo pipefail

# Usage : ./setup_homebrew.zsh [Brewfile|Brewfile.minimal|Brewfile.pentest]
# Par défaut : Brewfile (profil dev complet)
BREWFILE="${1:-Brewfile}"
BASEDIR="$(cd "$(dirname "$0")" && pwd)"

if [[ ! -f "$BASEDIR/$BREWFILE" ]]; then
  echo "Erreur : $BREWFILE introuvable dans $BASEDIR" >&2
  exit 1
fi

if exists brew; then
  echo "\n<<< Homebrew déjà installé, passage au bundle... >>>\n"
else
  echo "\n<<< Homebrew introuvable, installation... >>>\n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "\n<<< Installation des paquets depuis $BREWFILE... >>>\n"

brew bundle --file="$BASEDIR/$BREWFILE" --verbose

echo "\n<<< Homebrew Setup terminé ($BREWFILE). >>>\n"
