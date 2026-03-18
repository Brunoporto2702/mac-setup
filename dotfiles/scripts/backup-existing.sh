#!/usr/bin/env bash
set -euo pipefail

timestamp="$(date +%Y%m%d-%H%M%S)"

backup_file() {
  local file="$1"

  if [[ -L "$file" ]]; then
    return
  fi

  if [[ -e "$file" ]]; then
    local backup="${file}.bak.${timestamp}"
    mv "$file" "$backup"
    echo "Backup: $file -> $backup"
  fi
}

echo "==> Fazendo backup de configs existentes"

backup_file "$HOME/.zshrc"
backup_file "$HOME/.config/starship.toml"
backup_file "$HOME/.config/ghostty/config.ghostty"
backup_file "$HOME/.config/ghostty/config"
backup_file "$HOME/.config/nvim"

echo "==> Backup concluído"
