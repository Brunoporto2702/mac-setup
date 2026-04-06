# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A dotfiles and mac setup repo. Config files live here and are symlinked to their system locations — this repo is the single source of truth for all configuration. Editing files at their system paths (e.g. `~/.zshrc`) is the same as editing the repo, since they are symlinks.

## Scripts

All scripts live in `dotfiles/scripts/` and must be run from the `dotfiles/` directory:

```sh
cd dotfiles

# Full first-time setup (installs packages, backs up existing configs, creates symlinks)
./scripts/bootstrap.sh

# Install/update Homebrew packages only
./scripts/install-packages.sh

# Create symlinks only (use when adding a new config file to the repo)
./scripts/link-configs.sh
```

After changing `.zshrc` or other shell config, reload with `source ~/.zshrc`.

The active profile is stored in `~/.mac-profile` (e.g. `personal` or `work`). `bootstrap.sh` sets this on first run. To switch profiles, update `~/.mac-profile` and re-run `./scripts/link-configs.sh`.

## Architecture

The repo has two top-level areas:

- `dotfiles/` — shell config (zsh, starship, ghostty) and the scripts that install and link them
- `nvim/config/` — neovim config, symlinked to `~/.config/nvim`

`link-configs.sh` computes `REPO_ROOT` as the `dotfiles/` directory and `MAC_SETUP_ROOT` as its parent (the repo root), so the nvim symlink correctly targets `nvim/config/` at the repo root.

**Adding a new config file:** place it in `dotfiles/config/<tool>/`, add a `link_config` entry in `dotfiles/scripts/link-configs.sh`, and add the corresponding `backup_file` entry in `dotfiles/scripts/backup-existing.sh`. Then run `./scripts/link-configs.sh`.

**Adding a profile-specific config:** create a file next to the base config following the naming convention below. No changes to scripts needed — `link_config` picks it up automatically.

**Adding a new package:** edit `dotfiles/scripts/install-packages.sh` (common) or `install-packages.<profile>.sh` (profile-specific), then re-run it. `bootstrap.sh` runs base + profile script automatically; profile scripts can also be run standalone.

## Symlink map

`link-configs.sh` links the profile-specific file if it exists, otherwise falls back to the base.

| Repo path (base) | Profile override | System path |
|---|---|---|
| `dotfiles/config/zsh/base.zshrc` | `dotfiles/config/zsh/zshrc.<profile>` | `~/.zshrc` |
| `dotfiles/config/starship/starship.toml` | `dotfiles/config/starship/starship.<profile>.toml` | `~/.config/starship.toml` |
| `dotfiles/config/ghostty/config.ghostty` | `dotfiles/config/ghostty/config.<profile>.ghostty` | `~/.config/ghostty/config.ghostty` |
| `dotfiles/config/tmux/tmux.conf` | `dotfiles/config/tmux/tmux.<profile>.conf` | `~/.config/tmux/tmux.conf` |
| `nvim/config/` | — | `~/.config/nvim` |

Profile zshrc files source the base first, then add profile-specific config:
```zsh
source "$HOME/.dotfiles-root"
source "$MAC_SETUP_ROOT/dotfiles/config/zsh/base.zshrc"
# profile-specific additions below
```
