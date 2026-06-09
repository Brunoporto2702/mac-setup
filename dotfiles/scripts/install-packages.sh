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
brew install starship fzf zoxide eza bat ripgrep fd atuin mise uv tmux neovim stylua tree-sitter tree-sitter-cli lazygit zsh-syntax-highlighting zsh-autosuggestions rustup flyctl

# ffmpeg full build (libfreetype/harfbuzz/fontconfig — necessário pro drawtext).
# O tap principal do Homebrew distribui só o build "lite", sem suporte a fontes.
brew tap homebrew-ffmpeg/ffmpeg
brew uninstall --ignore-dependencies ffmpeg 2>/dev/null || true
brew install homebrew-ffmpeg/ffmpeg/ffmpeg --with-zimg

# Casks — instalados um a um e com --adopt pra serem idempotentes
# (--adopt assume apps já presentes em /Applications sem reinstalar/dar erro).
install_cask() {
  for cask in "$@"; do
    if brew list --cask "$cask" >/dev/null 2>&1; then
      echo "==> Cask '$cask' já instalado, pulando"
    else
      brew install --cask --adopt "$cask" || echo "!! Falha ao instalar cask '$cask', continuando"
    fi
  done
}

install_cask ghostty rectangle caffeine dbvisualizer claude obsidian 1password
# Fonts
install_cask font-martian-mono-nerd-font font-roboto-mono-nerd-font

if [[ -d "$(brew --prefix)/opt/fzf" ]]; then
  echo "==> Instalando key bindings/completion do fzf"
  "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish
fi

echo "==> Pacotes instalados"
