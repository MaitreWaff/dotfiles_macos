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

if ! command -v brew &>/dev/null; then
  echo "\n<<< Homebrew introuvable, installation... >>>\n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Charger brew dans la session courante (Apple Silicon ou Intel)
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "\n<<< Homebrew déjà installé, passage au bundle... >>>\n"
fi

echo "\n<<< Approbation des taps tiers... >>>\n"

# Homebrew 4.x exige une approbation explicite des taps tiers
local taps_to_trust=(hashicorp/tap ngrok/ngrok pulumi/tap)
for tap in "${taps_to_trust[@]}"; do
  if brew tap-info "$tap" &>/dev/null 2>&1; then
    brew trust "$tap" 2>/dev/null || true
  fi
done

echo "\n<<< Installation des paquets depuis $BREWFILE... >>>\n"

brew bundle --file="$BASEDIR/$BREWFILE" --verbose

echo "\n<<< Homebrew Setup terminé ($BREWFILE). >>>\n"
