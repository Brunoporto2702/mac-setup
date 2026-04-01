# nvim config

Neovim configuration using [lazy.nvim](https://github.com/folke/lazy.nvim), symlinked to `~/.config/nvim`.

## Structure

```
nvim/config/
├── init.lua
└── lua/
    ├── options.lua
    ├── keymaps.lua
    ├── autocmds.lua
    └── plugins/
        ├── base/        ← loaded for all profiles
        └── <profile>/   ← loaded only for the active profile (additive)
```

## Profile plugins

The active profile is read from `$MAC_PROFILE` (set from `~/.mac-profile`). Base plugins are always loaded. To add a plugin for a specific profile, drop a file into `lua/plugins/<profile>/`:

```sh
# Example: personal-only plugin
touch nvim/config/lua/plugins/personal/my-plugin.lua
```

No changes to `init.lua` needed — the directory is picked up automatically as long as it contains at least one `.lua` file.

## Lint / format

Format all Lua files:

```sh
stylua nvim/config/
```
