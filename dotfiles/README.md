# dotfiles

Setup de terminal para macOS com Ghostty, zsh e Starship.

## Estrutura

- config/: arquivos de configuração versionados
- scripts/: automações de instalação, backup e symlink

## Setup inicial

    chmod +x scripts/*.sh
    ./scripts/bootstrap.sh

`bootstrap.sh` will prompt for a profile (`personal`, `work`, or a custom name) on first run.

## Trocar de perfil

    echo "work" > ~/.mac-profile
    ./scripts/link-configs.sh

## Reaplicar symlinks

    ./scripts/link-configs.sh

## Recarregar shell atual

    source ~/.zshrc
