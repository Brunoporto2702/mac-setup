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
        └── *.lua   ← one file per plugin
```

## Lint / format

Format all Lua files:

```sh
stylua nvim/config/
```
