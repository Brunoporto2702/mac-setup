# dotfiles

Setup de terminal para macOS com Ghostty, zsh e Starship.

## Estrutura

- config/: arquivos de configuração versionados
- scripts/: automações de instalação, backup e symlink

## Setup inicial

    chmod +x scripts/*.sh
    ./scripts/bootstrap.sh

## Reaplicar symlinks

    ./scripts/link-configs.sh

## Recarregar shell atual

    source ~/.zshrc
