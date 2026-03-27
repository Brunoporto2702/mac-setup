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

## Architecture

The repo has two top-level areas:

- `dotfiles/` — shell config (zsh, starship, ghostty) and the scripts that install and link them
- `nvim/config/` — neovim config, symlinked to `~/.config/nvim`

`link-configs.sh` computes `REPO_ROOT` as the `dotfiles/` directory and `MAC_SETUP_ROOT` as its parent (the repo root), so the nvim symlink correctly targets `nvim/config/` at the repo root.

**Adding a new config file:** place it in `dotfiles/config/<tool>/`, add a `link_file` entry in `dotfiles/scripts/link-configs.sh`, and add the corresponding `backup_file` entry in `dotfiles/scripts/backup-existing.sh`. Then run `./scripts/link-configs.sh`.

**Adding a new package:** edit `dotfiles/scripts/install-packages.sh`, then re-run it.

## Symlink map

| Repo path | System path |
|---|---|
| `dotfiles/config/zsh/.zshrc` | `~/.zshrc` |
| `dotfiles/config/starship/starship.toml` | `~/.config/starship.toml` |
| `dotfiles/config/ghostty/config.ghostty` | `~/.config/ghostty/config.ghostty` |
| `nvim/config/` | `~/.config/nvim` |
