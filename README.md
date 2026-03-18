# mac-setup

A dotfiles and machine setup repo. Config files live here and are symlinked to their expected locations — meaning this repo is the source of truth for all configuration.

## First-time setup

```sh
cd dotfiles
./scripts/bootstrap.sh
```

This will:
1. Install Homebrew (if missing) and all packages
2. Back up any existing config files (as `.bak.<timestamp>`)
3. Create symlinks from your home directory into this repo

## How symlinks work

After bootstrap, your config files (`.zshrc`, `starship.toml`, `ghostty/config.ghostty`, `nvim/`) are symlinks pointing into this repo. Editing them in your editor is the same as editing the repo — changes are live immediately.

**Committing to using this repo means all config changes happen here.** Don't edit the files at their system paths directly (you'd be editing the repo anyway), and don't save config changes outside the repo.

## After adding a new package

Edit `dotfiles/scripts/install-packages.sh`, then re-run it:

```sh
cd dotfiles
./scripts/install-packages.sh
```

## After changing configs

Since symlinks are live, most changes take effect immediately or after reloading the shell:

```sh
source ~/.zshrc
```

**If you add a new config file to the repo** (new tool, new symlink entry in `link-configs.sh`), re-run the link script to create the new symlink:

```sh
cd dotfiles
./scripts/link-configs.sh
```

No need to re-run the full bootstrap.

## Configs managed

| File in repo | Symlinked to |
|---|---|
| `dotfiles/config/zsh/.zshrc` | `~/.zshrc` |
| `dotfiles/config/starship/starship.toml` | `~/.config/starship.toml` |
| `dotfiles/config/ghostty/config.ghostty` | `~/.config/ghostty/config.ghostty` |
| `nvim/config/` | `~/.config/nvim` |

## Packages installed

Via Homebrew: `starship`, `fzf`, `zoxide`, `eza`, `bat`, `ripgrep`, `fd`, `atuin`, `mise`, `tmux`, `neovim`

Casks: `ghostty`
