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

# Links profile version if it exists, otherwise falls back to base
link_config() {
  local base="$1"
  local profile_file="$2"
  local target="$3"

  if [[ -n "${PROFILE:-}" && -f "$profile_file" ]]; then
    link_file "$profile_file" "$target"
  else
    link_file "$base" "$target"
  fi
}

# Write repo root so profile configs can source base configs
echo "export MAC_SETUP_ROOT=$MAC_SETUP_ROOT" > "$HOME/.dotfiles-root"

# Load profile
PROFILE=""
if [[ -f "$HOME/.mac-profile" ]]; then
  PROFILE="$(cat "$HOME/.mac-profile")"
  echo "==> Profile: $PROFILE"
else
  echo "==> No profile set (using base configs). Create ~/.mac-profile to activate a profile."
fi

echo "==> Criando symlinks"

link_config \
  "$REPO_ROOT/config/zsh/base.zshrc" \
  "$REPO_ROOT/config/zsh/zshrc.$PROFILE" \
  "$HOME/.zshrc"

link_config \
  "$REPO_ROOT/config/starship/starship.toml" \
  "$REPO_ROOT/config/starship/starship.$PROFILE.toml" \
  "$HOME/.config/starship.toml"

link_config \
  "$REPO_ROOT/config/ghostty/config.ghostty" \
  "$REPO_ROOT/config/ghostty/config.$PROFILE.ghostty" \
  "$HOME/.config/ghostty/config.ghostty"

link_config \
  "$REPO_ROOT/config/tmux/tmux.conf" \
  "$REPO_ROOT/config/tmux/tmux.$PROFILE.conf" \
  "$HOME/.config/tmux/tmux.conf"

link_file "$MAC_SETUP_ROOT/nvim/config" "$HOME/.config/nvim"

echo "==> Symlinks concluídos"
