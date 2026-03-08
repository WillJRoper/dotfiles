# Plugin Modules

Each file in this directory returns a lazy.nvim plugin spec.

## Organization

General structure by feature area:

- UI/UX: `alpha.lua`, `lualine.lua`, `noice.lua`, `notify.lua`, `snacks.lua`, `colortheme.lua`
- Navigation and search: `telescope.lua`, `telescope-undo.lua`, `flash.lua`, `oil.lua`
- Editing ergonomics: `autocompletion.lua`, `comment.lua`, `indent-blankline.lua`, `virt-column.lua`, `yanky.lua`
- Syntax and parsing: `treesitter.lua`, `treesitter-text-objects.lua`
- Git: `neogit.lua`, `gitsigns.lua`, `git-conflict.lua`
- Language tooling: `lsp.lua`, `conform.lua`, `none-ls.lua`, `cspell.lua`, `schemastore.lua`
- Integrations and misc: `copilot.lua`, `copilot-chat.lua`, `opencode.lua`, `misc.lua`, `trouble.lua`, `vim-bbye.lua`, `nvim-tmux-navigation.lua`, `cellular-automaton.lua`

## How to Add a Plugin

1. Create a new file in this directory with one plugin spec
2. Use lazy-loading (`event`, `ft`, `cmd`, or key-triggered mappings) where sensible
3. Put plugin-specific keymaps inside that plugin file
4. Run headless validation:

```bash
nvim --headless "+Lazy! sync" "+checkhealth" +qa
```

## How to Remove a Plugin

1. Delete its spec file (or remove its returned spec)
2. Remove references from other plugin configs if present
3. Run `:Lazy clean` (or headless sync) to prune unused plugins

## Notes

- Generated plugin lockfiles are intentionally not tracked in this repo
- HPC-sensitive plugins should gate behavior through `require('core.env').is_hpc`
