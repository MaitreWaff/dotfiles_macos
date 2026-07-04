#!/usr/bin/env bash
# Bibliothèque partagée par uninstall-pentest / uninstall-dev / uninstall-minimal.
# Ce fichier n'est PAS exécutable directement : il doit être sourcé.
#
# Compatible bash 3.2 (bash livré par défaut sur macOS) : pas de mapfile/readarray,
# pas de `set -u` en amont (les tableaux vides + set -u plantent en bash 3.2).

# Extrait les valeurs d'un type d'entrée simple (brew/cask/tap/vscode) d'un Brewfile.
# Usage : brewfile_entries <fichier> <brew|cask|tap|vscode>
brewfile_entries() {
  local file="$1" keyword="$2"
  grep -oE "^${keyword} \"[^\"]+\"" "$file" | sed -E "s/^${keyword} \"//; s/\"\$//"
}

# Extrait les entrées Mac App Store sous forme "Nom|id".
brewfile_mas_entries() {
  local file="$1"
  grep -oE '^mas "[^"]+", id: [0-9]+' "$file" \
    | sed -E 's/^mas "([^"]+)", id: ([0-9]+)/\1|\2/'
}

# Demande confirmation, quitte proprement si refus.
confirm_or_abort() {
  local prompt="$1" confirm
  read -r -p "$prompt [y/N] " confirm
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Annulé."
    exit 0
  fi
}

uninstall_formulae() {
  local formula
  for formula in "$@"; do
    if brew list --formula 2>/dev/null | grep -qx "$formula"; then
      brew uninstall --formula --ignore-dependencies "$formula"
    else
      echo "Ignoré (non installé) : $formula"
    fi
  done
}

# Usage : uninstall_casks <true|false zap> <cask1> <cask2> ...
uninstall_casks() {
  local zap="$1"; shift
  local cask
  for cask in "$@"; do
    if brew list --cask 2>/dev/null | grep -qx "$cask"; then
      if [[ "$zap" == true ]]; then
        brew uninstall --cask --zap "$cask"
      else
        brew uninstall --cask "$cask"
      fi
    else
      echo "Ignoré (non installé) : $cask"
    fi
  done
}

uninstall_taps() {
  local tap
  for tap in "$@"; do
    if brew tap 2>/dev/null | grep -qx "$tap"; then
      brew untap "$tap"
    else
      echo "Ignoré (non tappé) : $tap"
    fi
  done
}

uninstall_vscode_extensions() {
  if [[ $# -eq 0 ]]; then return; fi
  if ! command -v code &>/dev/null; then
    echo "Commande 'code' introuvable — extensions VS Code ignorées."
    return
  fi
  local ext
  for ext in "$@"; do
    if code --list-extensions 2>/dev/null | grep -qix "$ext"; then
      code --uninstall-extension "$ext" || true
    else
      echo "Ignoré (non installée) : extension $ext"
    fi
  done
}

# Usage : uninstall_mas_apps <"Nom|id"> ...
uninstall_mas_apps() {
  if [[ $# -eq 0 ]]; then return; fi
  if ! command -v mas &>/dev/null; then
    echo "Commande 'mas' introuvable — apps Mac App Store ignorées."
    return
  fi
  local entry name id
  for entry in "$@"; do
    name="${entry%%|*}"
    id="${entry##*|}"
    if mas list 2>/dev/null | grep -q "^${id} "; then
      mas uninstall "$id" || true
    else
      echo "Ignoré (non installée) : $name (id $id)"
    fi
  done
}
