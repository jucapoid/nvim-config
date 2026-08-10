# Neovim Configuration

A modular Neovim setup built with [lazy.nvim](https://github.com/folke/lazy.nvim), focused on general development (C/C++, Lua, PHP, Python, JS/TS) with custom workflows for **ESP-IDF** embedded work and **Laravel** PHP projects.

**Leader key:** `<Space>`

Press `<Space>` and wait briefly to see all key groups via which-key.

## Structure

```
init.lua
├── config/options.lua       Editor defaults (numbers, tabs, clipboard, …)
├── config/keymaps.lua       Global keymaps (git, ESP-IDF, terminal)
├── config/lazy.lua          Plugin manager bootstrap
├── config/autocmds.lua      Autocommands (yank highlight)
├── config/diagnostics.lua   Diagnostic signs and UI
├── config/lsp.lua           LSP attach keymaps and diagnostic navigation
├── config/dap.lua           C/C++ debugging (codelldb)
├── lua/plugins/*.lua        Plugin specs (11 files, auto-imported)
├── lua/esp/*                ESP-IDF project detection and tooling
├── lua/tasks/*              Task terminal and runners
└── after/lsp/               Per-server LSP overrides (clangd, intelephense)
```

## Plugins

| Area | Plugins |
|------|---------|
| **Theme / editing** | tokyonight, treesitter, mini.nvim (ai, surround, comment, pairs) |
| **LSP** | mason, mason-lspconfig, mason-tool-installer, nvim-lspconfig, fidget |
| **Completion** | blink.cmp, friendly-snippets |
| **Navigation** | oil.nvim (file browser), telescope + fzf-native |
| **Git** | gitsigns, fugitive, diffview |
| **Format / lint** | conform.nvim (format on save), nvim-lint |
| **Debug** | nvim-dap, dap-ui, dap-virtual-text |
| **UI / nav aids** | which-key, trouble.nvim, aerial.nvim, todo-comments |
| **Laravel** | laravel.nvim (Artisan, routes, pickers, code actions) |

## Language support

**LSP:** bash, clangd, css, html, intelephense (PHP/Blade), json, lua, pyright, ts_ls, yaml.

**Format on save:** stylua (Lua), clang-format (C/C++), pint (PHP), prettierd (web/JSON/YAML/markdown).

**Lint:** selene, clangtidy, phpstan, eslint_d.

## Keymaps

### General

| Key | Action |
|-----|--------|
| `<leader><leader>` | Save file |
| `<leader>q` | Quit |
| `<C-h/j/k/l>` | Window navigation |
| `-` | Open parent directory (Oil) |

### Files — `<leader>n`

Oil.nvim file browser (flat directory listing, not a tree):

| Key | Action |
|-----|--------|
| `<leader>no` | Open at current file directory |
| `<leader>nf` | Toggle floating browser |
| `<leader>ns` | Open in left vertical split (sidebar) |
| `<leader>nc` | Open project root (CWD) |
| `<leader>np` | Open parent directory |
| `<leader>nh` | Toggle hidden files and open |

**Inside Oil:** `<CR>` open, `<C-s>` vsplit, `<C-h>` hsplit, `<C-p>` preview, `-` parent, `g.` toggle hidden, `q` close. Run `g?` in Oil for the full list.

### Find — `<leader>f`

Telescope: files, live grep, buffers, recents, help, commands, keymaps, LSP symbols, diagnostics.

### Git — `<leader>g`

Fugitive, Diffview, file/repo history, commit, blame. Buffer-local gitsigns hunk maps: `]h` / `[h`, `<leader>hs`, `<leader>hr`, `<leader>hp`.

### Laravel — `<leader>l`

Active in PHP/Blade projects and on `composer.json`. Requires a Laravel project root.

| Key | Action |
|-----|--------|
| `<leader>ll` | Laravel picker |
| `<leader>la` | Artisan commands |
| `<leader>lr` | Routes |
| `<leader>lm` | Make generators |
| `<leader>lt` | Code actions |
| `<leader>lu` | Artisan Hub |
| `<C-g>` | View finder |

Run `:checkhealth laravel` to verify setup (plugin loads on startup via VeryLazy).

### ESP-IDF — `<leader>e`

Auto-detects projects via `sdkconfig` / `CMakeLists.txt` + `main/`.

| Key | Action |
|-----|--------|
| `<leader>eb` | Build (`idf.py build`) |
| `<leader>ef` | Flash |
| `<leader>em` | Monitor |
| `<leader>ec` | Full clean |
| `<leader>ek` | menuconfig |
| `<leader>eB` | Select board |
| `<leader>ep` | Select serial port |
| `<leader>es` | Status panel |

### LSP (on attach)

| Key | Action |
|-----|--------|
| `gd` / `gD` | Go to definition / declaration |
| `gr` / `gi` | References / implementation |
| `K` | Hover |
| `<leader>cr` | Rename |
| `<leader>ca` | Code action |
| `<leader>cf` | Format buffer |
| `[d` / `]d` | Previous / next diagnostic |

### Debug

`F5` continue, `F10`/`F11`/`F12` step, `<leader>db` breakpoint, `<leader>du` toggle DAP UI.

## Custom modules

### ESP-IDF (`lua/esp/`)

Detects ESP-IDF project roots, persists board/port/baud per project, runs `idf.py` commands in the task terminal, and shows a status panel with project health.

### Tasks (`lua/tasks/`)

Bottom terminal split for running shell commands scoped to the detected project root.

## Getting started

```bash
# First launch installs lazy.nvim and plugins automatically
nvim

# Inside Neovim
:Lazy sync
:MasonInstall intelephense   # if PHP support is needed
:checkhealth laravel         # verify Laravel integration
```

## Requirements

- Neovim ≥ 0.10
- `ripgrep` (Telescope, Laravel view finder)
- `jq` (optional, Laravel config display)
- Writable `vendor/` in Laravel projects (laravel.nvim introspection)
- ESP-IDF toolchain on `$PATH` for embedded workflow
