# Neovim Configuration

This directory is your Chezmoi-managed Neovim config source.

- Source path in this repo: `home/dot_config/nvim`
- Target path on machine: `~/.config/nvim`
- Entry point: `init.lua`
- Neovim version target: `0.11+`

## Architecture

Load order is simple and explicit:

1. `init.lua` loads core modules from `lua/core/`
2. `init.lua` bootstraps `lazy.nvim` if needed
3. `lazy.nvim` loads plugin specs from `lua/plugins/`

Directory layout:

- `init.lua`: bootstrap and startup wiring
- `lua/core/`: options, keymaps, environment detection, snippets/autocmds
- `lua/plugins/`: one plugin spec per file
- `lua/utils/`: shared helper modules
- `.stylua.toml`, `.clang-format`, `ruff.toml`: formatting and lint preferences

## Environment Behavior (HPC-aware)

`lua/core/env.lua` exposes `hostname` and `is_hpc`.

- Auto-detects COSMA login hosts (`login7*`, `login8*` patterns)
- Supports manual override:
  - `NVIM_HPC=1` forces HPC mode
  - `NVIM_HPC=0` forces non-HPC mode
- Copilot plugins check `require('core.env').is_hpc` and disable themselves automatically on HPC

## LSP, Formatting, and Diagnostics

- LSP orchestration lives in `lua/plugins/lsp.lua`
  - Uses Neovim 0.11 APIs (`vim.lsp.config`, `vim.lsp.enable`)
  - Mason installs language servers and tools
- Formatting is configured in `lua/plugins/conform.lua`
- Extra diagnostics/code actions are configured in:
  - `lua/plugins/none-ls.lua`
  - `lua/plugins/cspell.lua`

If you need to add a language:

1. Add/update server config in `lua/plugins/lsp.lua`
2. Add any formatter in `lua/plugins/conform.lua`
3. Add optional diagnostics/code actions in `lua/plugins/none-ls.lua` or `lua/plugins/cspell.lua`

## Keymap Conventions

- Leader key is `<Space>`
- Global keymaps are in `lua/core/keymaps.lua`
- LSP buffer-local keymaps are defined in `lua/plugins/lsp.lua`
- Plugin-specific keymaps are generally co-located with plugin specs

Notable global examples:

- `<leader>ww`: save without auto-format (`:noautocmd w`)
- `<leader>gg`: open Neogit
- `<leader>oo`, `<leader>oa`, `<leader>oA`: OpenCode integration
- `[d` / `]d`: previous/next diagnostic

## Validation and Maintenance

After changing this config, run:

```bash
nvim --headless "+Lazy! sync" "+checkhealth" +qa
```

Useful maintenance commands:

```bash
stylua init.lua lua
ruff check
```

Chezmoi flow:

```bash
chezmoi diff
chezmoi apply
```
