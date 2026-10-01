# Neovim Configuration

A modular Neovim setup built with [lazy.nvim](https://github.com/folke/lazy.nvim), focused on general development (C/C++, Lua, PHP, Python, JS/TS) with a custom **ESP-IDF** embedded workflow.

**Leader key:** `<Space>`

Press `<Space>` and wait briefly to see all key groups via which-key.

## Structure

```
init.lua
├── config/options.lua       Editor defaults (numbers, tabs, clipboard, …)
├── config/keymaps.lua       Global keymaps (git, ESP-IDF, terminal)
├── config/lazy.lua          Plugin manager bootstrap
├── config/autocmds.lua      Autocommands (yank highlight, terminal keys)
├── config/diagnostics.lua   Diagnostic signs and UI
├── config/lsp.lua           LSP attach keymaps and diagnostic navigation
├── config/dap.lua           C/C++ debugging (codelldb)
├── lua/plugins/*.lua        Plugin specs (auto-imported)
├── lua/esp/*                ESP-IDF project detection and tooling
├── lua/tasks/*              Task terminal and runners
└── after/lsp/               Per-server LSP overrides (clangd)
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

## Language support

**LSP:** bash, clangd, css, html, intelephense (PHP), json, lua, pyright, ts_ls, yaml.

**Format on save:** stylua (Lua), clang-format (C/C++), pint (PHP), prettierd (web/JSON/YAML/markdown). `<leader>cf` formats a visual selection, or the whole file when nothing is selected.

**Lint:** selene, clangtidy, phpstan, eslint_d.

## Keymaps

### General

| Key | Action |
|-----|--------|
| `<leader><leader>` | Save file |
| `<leader>q` | Quit |
| `<C-h/j/k/l>` | Window navigation |
| `-` | Open parent directory (Oil) |

### Terminal — `<leader>tt`

Toggle a bottom terminal split. Opening it focuses your editor again; click the terminal pane and press `i` to type into the shell.

| Situation | Keys | Action |
|-----------|------|--------|
| Typing in terminal | `Esc` | Leave terminal insert → normal mode in that pane |
| Typing in terminal | `Ctrl-\` then `Ctrl-n` | Same (built-in default) |
| Normal mode in terminal pane | `i` | Enter terminal insert again |
| Normal mode in terminal pane | `q` or `<leader>tt` | Hide pane (shell keeps running) |
| Window focus | `Ctrl-h/j/k/l` | Jump to another window (from terminal insert too) |

Do **not** use `Ctrl-d` in an empty shell — that sends EOF and kills the session.

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

Press `<Space>f` to open the Find menu in which-key.

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files (project) |
| `<leader>f.` | Find files near current file |
| `<leader>fF` | Find all files (including ignored/hidden) |
| `<leader>fB` | Fuzzy find in current buffer |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fr` | Recent files |
| `<leader>fc` | Find class (workspace symbols) |
| `<leader>fm` | Find method (workspace symbols) |
| `<leader>fs` | Document symbols (current file) |
| `<leader>fS` | Workspace symbols (all kinds) |
| `<leader>fT` | Find type definition (picker) |
| `<leader>fR` | Find references (picker) |
| `<leader>fI` | Find implementations (picker) |
| `<leader>fw` | Find word under cursor |
| `<leader>fd` | Diagnostics |
| `<leader>fh` | Help tags |
| `<leader>fk` | Keymaps |
| `<leader>f:` | Commands |

### Git — `<leader>g`

Fugitive, Diffview, file/repo history, commit, blame. Buffer-local gitsigns hunk maps: `]h` / `[h`, `<leader>hs`, `<leader>hr`, `<leader>hp`.

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
| `gr` / `gi` / `gt` | References / implementation / type definition |
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
nvim
:Lazy sync
:checkhealth vim.lsp
```

## Requirements

- Neovim ≥ 0.10
- `ripgrep` (Telescope)
- ESP-IDF toolchain on `$PATH` for embedded workflow
