# mac-setup

A dotfiles and machine setup repo. Config files live here and are symlinked to their expected locations — this repo is the single source of truth for all configuration.

## First-time setup

```sh
cd dotfiles
./scripts/bootstrap.sh
```

This will:
1. Install Homebrew (if missing) and all packages
2. Back up any existing config files (as `.bak.<timestamp>`)
3. Create symlinks from your home directory into this repo

## After adding a new package

Edit `dotfiles/scripts/install-packages.sh`, then re-run it:

```sh
cd dotfiles
./scripts/install-packages.sh
```

## After changing configs

Symlinks are live, so most changes take effect immediately or after reloading the shell:

```sh
source ~/.zshrc
```

**If you add a new config file to the repo**, re-run the link script to create the new symlink:

```sh
cd dotfiles
./scripts/link-configs.sh
```

## Symlink map

| Repo path | System path |
|---|---|
| `dotfiles/config/zsh/zshrc` | `~/.zshrc` |
| `dotfiles/config/starship/starship.toml` | `~/.config/starship.toml` |
| `dotfiles/config/ghostty/config.ghostty` | `~/.config/ghostty/config.ghostty` |
| `dotfiles/config/tmux/tmux.conf` | `~/.config/tmux/tmux.conf` |
| `nvim/config/` | `~/.config/nvim` |

> A personal/work profile system was removed at tag [`profile-system-v1`](https://github.com/Brunoporto2702/mac-setup/releases/tag/profile-system-v1). See that tag if you want to adapt it.

## Packages installed

**Homebrew formulae:** `starship`, `fzf`, `zoxide`, `eza`, `bat`, `ripgrep`, `fd`, `atuin`, `mise`, `tmux`, `neovim`, `lazygit`, `stylua`, `tree-sitter`, `zsh-syntax-highlighting`, `zsh-autosuggestions`

**Homebrew casks:** `ghostty`, `rectangle`, `caffeine`
