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
│   ├── dap.lua       # Debug adapter config (delve)
│   ├── colorscheme.lua
│   ├── autocommands.lua
│   ├── find.lua      # Telescope find
│   ├── grep.lua      # Telescope live grep
│   ├── statusline.lua
│   ├── netrw.lua
│   └── plugins/
│       └── init.lua  # Plugin loading (DAP lazy-loaded)
├── lsp/
│   ├── lua_ls.lua
│   ├── gopls.lua
│   ├── ts_ls.lua
│   ├── tailwindcss.lua
│   ├── rust_analyzer.lua
│   ├── clangd.lua
│   ├── dartls.lua
│   ├── sqls.lua
│   ├── tinymist.lua
│   └── golangci_lint_ls.lua
└── colors/
    └── miku.lua       # Colorscheme
```

## Startup Flow

1. **init.lua** → loads modules in order (options, keymaps, LSP, etc.)
2. **LSP** → lazy-loaded on `FileType` event (all servers on first filetype)
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

| Tool | Purpose | Install |
|------|---------|---------|
| `nvim-dap` | Debug adapter | via pack |
| `dlv` | Go debugger | `go install .../dlv@latest` |
| `lua-language-server` | Lua LSP | system package |
| `gopls` | Go LSP | built-in with Go |
| `typescript-language-server` | TS LSP | `npm i -g typescript typescript-language-server` |

## Docker

```bash
# Build & push (on push to master)
docker build -t ghcr.io/<user>/minimalist-nvim:latest .

# Run
docker run -it ghcr.io/<user>/minimalist-nvim:latest

# With local config
docker run -it -v ~/.config/nvim:/root/.config/nvim ghcr.io/<user>/minimalist-nvim:latest
```

Image: `ghcr.io/<user>/minimalist-nvim` (auto-built on master push)
