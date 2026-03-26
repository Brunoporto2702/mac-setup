#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MAC_SETUP_ROOT="$(dirname "$REPO_ROOT")"

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/ghostty"
mkdir -p "$HOME/.config/tmux"

link_file() {
  local source="$1"
  local target="$2"

  ln -sfn "$source" "$target"
  echo "Linkado: $target -> $source"
}

echo "==> Criando symlinks"

link_file "$REPO_ROOT/config/zsh/.zshrc" "$HOME/.zshrc"
link_file "$REPO_ROOT/config/starship/starship.toml" "$HOME/.config/starship.toml"
link_file "$REPO_ROOT/config/ghostty/config.ghostty" "$HOME/.config/ghostty/config.ghostty"
link_file "$MAC_SETUP_ROOT/nvim/config" "$HOME/.config/nvim"
link_file "$REPO_ROOT/config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"

echo "==> Symlinks concluídos"
