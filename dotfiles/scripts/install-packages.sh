#!/usr/bin/env bash
set -euo pipefail

echo "==> Instalando dependências"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Este script foi feito para macOS."
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "==> Homebrew não encontrado. Instalando..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

brew update
brew install starship fzf zoxide eza bat ripgrep fd atuin mise tmux neovim stylua tree-sitter tree-sitter-cli lazygit zsh-syntax-highlighting zsh-autosuggestions
brew install --cask ghostty rectangle caffeine
# Fonts
brew install --cask font-martian-mono-nerd-font font-roboto-mono-nerd-font

if [[ -d "$(brew --prefix)/opt/fzf" ]]; then
  echo "==> Instalando key bindings/completion do fzf"
  "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
fi

echo "==> Pacotes instalados"
