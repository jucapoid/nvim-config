# Neovim keybindings cheat sheet

**Leader:** `Space`  
**Forgot everything?** Press `Space` and wait — **which-key** shows the menu.

Mnemonic for top-level groups:

| Prefix | Think… |
|--------|--------|
| `Space f` | **F**ind (Telescope) |
| `Space n` | **N**avigate files (Oil) |
| `Space g` | **G**it |
| `Space l` | **L**aravel |
| `Space e` | **E**SP-IDF |
| `Space c` | **C**ode (LSP on buffer) |
| `Space d` | **D**ebug |
| `Space x` | e**X** diagnostics (Trouble) |
| `Space a` | **A**erial outline |

---

## Essentials

| Keys | Action |
|------|--------|
| `Space Space` | Save |
| `Space q` | Quit |
| `Esc` | Clear search highlight |
| `Ctrl-h/j/k/l` | Move between windows |
| `n` / `N` | Next/prev search match (stay centered) |
| `Ctrl-d` / `Ctrl-u` | Page down/up (stay centered) |
| `-` | Open parent directory (Oil) |
| `Space tt` | Toggle terminal (bottom) |

---

## Find — `Space f` (Telescope)

| Keys | Action |
|------|--------|
| `ff` | Files in project |
| `f.` | Files near current file |
| `fF` | All files (incl. hidden / gitignored) |
| `fB` | Fuzzy search in current buffer |
| `fg` | Live grep (project text) |
| `fw` | Grep word under cursor |
| `fb` | Open buffers |
| `fr` | Recent files |
| `fc` | Find **class** (needs LSP) |
| `fm` | Find **method** (needs LSP) |
| `fs` | Symbols in this file |
| `fS` | Symbols in workspace |
| `fT` | Type definitions (picker) |
| `fR` | References (picker) |
| `fI` | Implementations (picker) |
| `fd` | Diagnostics (picker) |
| `ft` | TODO comments (Telescope) |
| `fh` | Help tags |
| `fk` | All keymaps |
| `f:` | Ex commands |

**LSP pickers:** open a source file in the project first so a language server is running (`:checkhealth vim.lsp`).

---

## Files — `Space n` (Oil)

| Keys | Action |
|------|--------|
| `no` | Open Oil at current file’s folder |
| `nf` | Floating file browser |
| `ns` | Sidebar (vertical split) |
| `nc` | Open project root (cwd) |
| `np` | Open parent folder |
| `nh` | Toggle hidden files + open |

### Inside Oil

| Keys | Action |
|------|--------|
| `Enter` | Open (closes Oil) |
| `Ctrl-s` | Open in vertical split |
| `Ctrl-h` | Open in horizontal split |
| `Ctrl-p` | Preview |
| `Ctrl-l` | Refresh |
| `-` | Parent directory |
| `_` | Jump to cwd |
| `g.` | Toggle hidden |
| `q` / `Esc` | Close |
| `g?` | Help |

---

## LSP (code buffers)

| Keys | Action |
|------|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | References |
| `gi` | Implementation |
| `gt` | Type definition |
| `K` | Hover docs |
| `[d` / `]d` | Prev / next diagnostic |
| `Space cr` | Rename |
| `Space ca` | Code action |
| `Space cf` | Format buffer |

---

## Git — `Space g`

| Keys | Action |
|------|--------|
| `gg` | Fugitive (`:Git`) |
| `gd` | Diffview |
| `gh` | File history |
| `gH` | Repo history |
| `gc` | Commit |
| `gb` | Blame |

**In buffer (gitsigns):**

| Keys | Action |
|------|--------|
| `]h` / `[h` | Next / prev hunk |
| `Space hs` | Stage hunk |
| `Space hr` | Reset hunk |
| `Space hp` | Preview hunk |
| `Space hb` | Blame line |

---

## Laravel — `Space l` (PHP / Blade projects)

| Keys | Action |
|------|--------|
| `ll` | Main Laravel picker |
| `la` | Artisan |
| `lr` | Routes |
| `lm` | Make generators |
| `lc` | Custom commands |
| `lo` | Resources |
| `lf` | Related files |
| `lv` | View finder |
| `lt` | Code actions |
| `lu` | Artisan Hub |
| `lp` | Command center |
| `lh` | Docs |
| `Ctrl-g` | View finder |
| `gf` | Go to route/view/config (when on a string) |

---

## ESP-IDF — `Space e`

Open a file under the project (e.g. `main/…`) first.

| Keys | Action |
|------|--------|
| `eb` | Build (`idf.py build` → quickfix) |
| `ef` | Flash |
| `em` | Monitor |
| `ec` | Full clean |
| `ek` | menuconfig |
| `eB` | Select board |
| `ep` | Select port |
| `es` | Status / doctor |

---

## Debug — `Space d`

| Keys | Action |
|------|--------|
| `F5` | Continue |
| `F10` | Step over |
| `F11` | Step into |
| `F12` | Step out |
| `db` | Toggle breakpoint |
| `dB` | Conditional breakpoint |
| `dr` | Debug REPL |
| `du` | Toggle DAP UI |

---

## Diagnostics & outline — `Space x` / `Space a`

| Keys | Action |
|------|--------|
| `xx` | Trouble: workspace diagnostics |
| `xX` | Trouble: buffer diagnostics |
| `xs` | Trouble: symbols |
| `xl` | Trouble: LSP list |
| `xq` | Trouble: quickfix |
| `xr` | Trouble: location list |
| `xt` | TODOs in Trouble |
| `Space a` | Toggle Aerial outline |
| `{` / `}` | Prev / next symbol (Aerial) |
| `]t` / `[t` | Next / prev TODO |

---

## Insert mode — completion (blink.cmp)

| Keys | Action |
|------|--------|
| `Ctrl-Space` | Show completion / docs |
| `Tab` / `Shift-Tab` | Next / prev item |
| `Enter` | Accept |

---

## Quick reference card (print this)

```
SAVE/QUIT     Space Space    Space q
FIND FILE     Space ff       Space f. (nearby)    Space fg (grep)
CLASS/METHOD  Space fc       Space fm             (LSP must be on)
FILES OIL     Space no       Space ns (sidebar)   -
GIT           Space gg       Space gd             ]h [h
LARAVEL       Space la       Space lr       Space lf
ESP           Space eb       Space ef       Space em
LSP JUMP      gd  gr  gt  K
DEBUG         F5  F10  Space db
HELP          Space fk       Space (wait)         g? (in Oil)
```

---

## After a long break

1. `nvim` → `:Lazy sync` if plugins complain  
2. `:checkhealth vim.lsp` — is your language server attached?  
3. `:checkhealth laravel` — in a Laravel repo  
4. `Space fk` — search keymaps inside Neovim  
5. Read `README.md` for setup notes  
