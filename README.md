# minimalist-nvim

A minimal, fast Neovim configuration with LSP, DAP, and essential editing features. No plugin manager — uses Neovim's built-in `vim.pack.add`.

## Structure

```
nvim/
├── init.lua           # Entry point: loads all modules
├── lua/
│   ├── options.lua    # Neovim settings
│   ├── keymaps.lua    # Global keybindings
│   ├── lsp.lua        # LSP config (lua_ls, gopls)
│   ├── dap.lua        # Debug adapter config (delve)
│   ├── colorscheme.lua
│   ├── autocommands.lua
│   ├── find.lua       # Telescope find
│   ├── grep.lua       # Telescope live grep
│   ├── statusline.lua
│   ├── netrw.lua
│   └── plugins/
│       └── init.lua   # Plugin loading (DAP lazy-loaded)
├── lsp/
│   ├── lua_ls.lua
│   └── gopls.lua
└── colors/
    └── miku.lua       # Colorscheme
```

## Flow

1. **init.lua** → loads modules in order (options, keymaps, LSP, etc.)
2. **LSP** → lazy-loaded on `FileType` event for `lua` or `go` files
3. **DAP** → lazy-loaded on `VimEnter` after startup completes
4. **Plugins** → via `vim.pack.add()` in `lua/plugins/dap.lua`

## Keybindings

| Key | Action |
|-----|--------|
| `<leader>do` | DAP toggle breakpoint |
| `<leader>dd` | DAP continue/start |
| `<leader>dk` | DAP step into |
| `<leader>dj` | DAP step over |
| `<leader>dl` | DAP step out |
| `<leader>lf` | LSP format |
| `<leader>ld` | LSP goto definition |
| `<leader>lt` | LSP diagnostics (qf list) |

## Dependencies

- Neovim 0.10+
- `nvim-dap` (installed via pack)
- `dlv` (Go debugger, `go install ...`)
- `lua_ls`, `gopls` (LSP servers)
