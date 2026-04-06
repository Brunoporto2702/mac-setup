# mac-setup

A dotfiles and machine setup repo. Config files live here and are symlinked to their expected locations — this repo is the single source of truth for all configuration.

## First-time setup

```sh
cd dotfiles
./scripts/bootstrap.sh
```

This will:
1. Install Homebrew (if missing) and all packages
2. Prompt for a profile (`personal`, `work`, or a custom name)
3. Back up any existing config files (as `.bak.<timestamp>`)
4. Create symlinks from your home directory into this repo

## Profiles

The active profile is stored in `~/.mac-profile`. It controls which config variant gets symlinked and which nvim plugins get loaded.

**Switch profile:**

```sh
echo "work" > ~/.mac-profile
cd dotfiles && ./scripts/link-configs.sh
```

**How it works:**
- Packages: `bootstrap.sh` always runs `install-packages.sh` (base), then runs `install-packages.<profile>.sh` if it exists. Profile scripts can also be run standalone.
- Shell/terminal configs: if a profile variant exists (e.g. `zshrc.work`), it gets symlinked instead of the base. Profile files source the base first, then add profile-specific config.
- Nvim plugins: `lua/plugins/base/` is always loaded. Drop files into `lua/plugins/<profile>/` for profile-specific plugins — no other changes needed.

## After adding a new package

For packages common to all machines, edit `dotfiles/scripts/install-packages.sh`. For profile-specific packages, edit `dotfiles/scripts/install-packages.<profile>.sh` (create it if it doesn't exist). Then re-run it:

```sh
cd dotfiles
./scripts/install-packages.sh         # base
./scripts/install-packages.personal.sh  # example: personal profile
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

`link-configs.sh` links the profile variant if it exists, otherwise falls back to the base.

| Repo path (base) | Profile override | System path |
|---|---|---|
| `dotfiles/config/zsh/base.zshrc` | `dotfiles/config/zsh/zshrc.<profile>` | `~/.zshrc` |
| `dotfiles/config/starship/starship.toml` | `dotfiles/config/starship/starship.<profile>.toml` | `~/.config/starship.toml` |
| `dotfiles/config/ghostty/config.ghostty` | `dotfiles/config/ghostty/config.<profile>.ghostty` | `~/.config/ghostty/config.ghostty` |
| `dotfiles/config/tmux/tmux.conf` | `dotfiles/config/tmux/tmux.<profile>.conf` | `~/.config/tmux/tmux.conf` |
| `nvim/config/` | — | `~/.config/nvim` |

## Packages installed

**Homebrew formulae:** `starship`, `fzf`, `zoxide`, `eza`, `bat`, `ripgrep`, `fd`, `atuin`, `mise`, `tmux`, `neovim`, `lazygit`, `stylua`, `tree-sitter`, `zsh-syntax-highlighting`, `zsh-autosuggestions`

**Homebrew casks:** `ghostty`, `rectangle`, `caffeine`
