# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Configuration Overview

This is a modern Neovim v0.11.4+ configuration built around the Lazy.nvim plugin manager. The configuration follows a modular structure with clear separation between core settings, plugins, and utilities. Updated for Neovim 0.11 features including enhanced LSP capabilities, improved diagnostics, and modern UI improvements.

## Architecture

### Core Structure
- `init.lua`: Entry point that loads core modules and sets up Lazy.nvim plugin manager
- `lua/core/`: Core Neovim settings
  - `options.lua`: Global vim settings (indentation, search, display)
  - `keymaps.lua`: Global key mappings and leader key configuration (space)
  - `snippets.lua`: Custom snippets, diagnostic configuration, and highlight-on-yank
- `lua/plugins/`: Plugin configurations (each plugin in its own file)
- `lua/utils/`: Utility functions and custom tools
- `lazy-lock.json`: Plugin version lockfile managed by Lazy.nvim

### Key Design Principles
- **Leader key**: Space (`<leader>` = ` `)
- **Plugin management**: Lazy.nvim with automatic installation and lazy loading
- **LSP integration**: Mason.nvim for automatic LSP server installation with Neovim 0.11 enhancements
- **Formatting**: Auto-format on save via none-ls
- **Modern UI**: Enhanced diagnostics, folding (ufo), and navigation (flash.nvim)
- **Project structure**: Telescope-based fuzzy finding and project management

## Language Support

### LSP Servers (Auto-installed via Mason)
- **Python**: `pylsp` (optimized for large repos) + `ruff` LSP (ultra-fast linting)
- **C/C++**: `clangd` (with enhanced configuration)
- **JavaScript/TypeScript**: `ts_ls` (with inlay hints)
- **Lua**: `lua_ls` (Neovim-optimized)
- **LaTeX**: `texlab` (with latexmk integration)
- **Shell/Bash**: `bashls`
- **Web**: `html`, `cssls` 
- **Data**: `jsonls`, `yamlls` (with schema validation)
- **Other**: `dockerls`, `marksman` (Markdown)

### Formatters & Linters (Auto-installed via Mason)
- **Python**: ruff (linting + formatting)
- **JavaScript/TypeScript**: prettier, eslint_d
- **Lua**: stylua
- **C/C++**: clang-format
- **Shell**: shfmt
- **Makefiles**: checkmake

### Python-Specific Configuration
- **pylsp**: Full-featured Python LSP with maximum functionality
- **Division of labor**: pylsp handles language features, ruff handles linting/formatting
- **Core features**:
  - **Jedi**: Full completions, hover, references, signatures, definitions
  - **Rope**: Advanced refactoring, auto-imports, renaming
  - **Mypy**: Live type checking with daemon mode
  - **Preloading**: numpy, pandas, matplotlib, scipy, astropy
  - **Folding**: Code folding support
- **ruff integration**: Handles all linting, formatting, import sorting
- **Performance**: Caches common libraries, non-eager loading

## Key Bindings

### Navigation & File Management
- `<leader>sf`: Search files (Telescope)
- `<leader>sg`: Live grep (Telescope)
- `<leader>sp`: Switch projects (Telescope)
- `<leader><leader>`: Find existing buffers
- `<leader>gg`: Open Neogit (Git interface)
- `<Tab>` / `<S-Tab>`: Navigate buffers
- `<leader>x`: Close buffer
- `s`: Flash jump (modern navigation)
- `S`: Flash treesitter jump

### LSP Features
- `gd`: Go to definition (Telescope)
- `gr`: Go to references (Telescope)
- `gI`: Go to implementation
- `<leader>rn`: Rename symbol
- `<leader>ca`: Code actions
- `<leader>D`: Type definition
- `<leader>K`: Enhanced hover documentation
- `<leader>lf`: LSP format document
- `<leader>th`: Toggle inlay hints
- `[d]` / `]d`: Navigate diagnostics

### Trouble (Enhanced Diagnostics)
- `<leader>xx`: Toggle diagnostics (Trouble)
- `<leader>xX`: Buffer diagnostics (Trouble)
- `<leader>cs`: Symbols (Trouble)
- `<leader>cl`: LSP definitions/references (Trouble)

### Window Management
- `<leader>v` / `<leader>|`: Vertical split
- `<leader>h` / `<leader>-`: Horizontal split
- `<C-h/j/k/l>`: Navigate between splits
- `<C-h/j/k/l>` (in terminal): Terminal navigation

### Modern Folding (UFO)
- `zR`: Open all folds
- `zM`: Close all folds
- `zr`: Open folds except kinds
- `zm`: Close folds with

### Text Manipulation
- `J` (visual): Move selection down
- `K` (visual): Move selection up
- `<C-c>` (insert): Better escape

### Quickfix Navigation
- `<leader>co`: Open quickfix list
- `<leader>cc`: Close quickfix list
- `]q` / `[q`: Next/previous quickfix item

### Git Operations (Complete `<leader>g` organization)
- `<leader>gg`: Open Neogit (Git interface)
- **Conflict Resolution**:
  - `<leader>gn`: Next git conflict
  - `<leader>gp`: Previous git conflict
  - `<leader>gco`: Choose ours (current branch)
  - `<leader>gct`: Choose theirs (incoming branch)
  - `<leader>gcb`: Choose both
  - `<leader>gc0`: Choose none
- **Hunk Operations**:
  - `<leader>ghs`: Stage hunk
  - `<leader>ghr`: Reset hunk
  - `<leader>ghu`: Undo stage hunk
  - `<leader>ghp`: Preview hunk
- **Buffer Operations**:
  - `<leader>gS`: Stage entire buffer
  - `<leader>gR`: Reset entire buffer
- **Blame & Diff**:
  - `<leader>gb`: Blame line
  - `<leader>gd`: Diff against index
  - `<leader>gD`: Diff against last commit
- **Toggles**:
  - `<leader>gtb`: Toggle blame line
  - `<leader>gtD`: Toggle deleted lines

### Custom Functions
- `<leader>mc`: Align YAML comments (custom utility in utils/myfunctions/comments.lua)

## Project Management

### Telescope Project Configuration
Projects are organized in these base directories:
- `~/Research`
- `~/Miscellaneous` 
- `~/Teaching`
- `~/dotfiles`

Access via `<leader>sp` to switch between projects quickly.

## Development Workflow

### Modern LSP Setup (Neovim 0.11+)
1. Uses native `vim.lsp.config()` and `vim.lsp.enable()` for better performance
2. Language servers auto-installed via Mason
3. Servers auto-enable when opening appropriate file types
4. Run `:Mason` to view/manage installed tools
5. Enhanced floating windows with rounded borders

### Key LSP Improvements
- **Better Python support**: Switched from pylsp to basedpyright for large repos
- **Enhanced C/C++**: Optimized clangd with background indexing and clang-tidy
- **Inlay hints**: Available for TypeScript, Rust, and other supported languages
- **Schema validation**: JSON/YAML files get intelligent completion and validation

### Formatting
- Auto-format on save via none-ls integration
- Manual formatting: `<leader>lf` or `:lua vim.lsp.buf.format()`
- Language-specific formatters in `lua/plugins/none-ls.lua`

### Plugin Management
- Add new plugins to appropriate files in `lua/plugins/`
- Run `:Lazy` to manage plugins (install, update, clean)
- All configurations optimized for lazy-loading

## Common Tasks

### Adding a New Language
1. Add LSP server to `servers` table in `lua/plugins/lsp.lua`
2. Add formatter/linter to `ensure_installed` in `lua/plugins/none-ls.lua`
3. Add formatting source to `sources` array if needed

### Customizing Keybindings
- Global keymaps: `lua/core/keymaps.lua`
- Plugin-specific keymaps: within respective plugin files
- LSP keymaps: defined in `lua/plugins/lsp.lua` LspAttach autocmd

### Debugging Configuration
- LSP issues: `:LspInfo`, `:LspLog`
- Plugin issues: `:Lazy profile`, `:Lazy health`
- Null-ls issues: `:NullLsLog` (if debug enabled)

## Configuration Philosophy

This configuration prioritizes:
- **Minimal startup time**: Lazy-loading and efficient plugin configuration
- **Language-agnostic**: Strong support for multiple programming languages
- **Modern tooling**: Latest LSP servers, formatters, and development tools
- **Ergonomic keybindings**: Logical, memorable key mappings
- **Visual clarity**: Clean UI with good syntax highlighting and diagnostics