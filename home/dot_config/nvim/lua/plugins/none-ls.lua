-- Plugin: none-ls
-- URL: https://github.com/nvimtools/none-ls.nvim
--
-- Description:
-- `none-ls` is a versatile Neovim plugin that allows you to integrate various formatters,
-- linters, and code analysis tools into Neovim using the Language Server Protocol (LSP).
-- This configuration keeps none-ls for diagnostics/code-actions only. Formatting is handled
-- by conform.nvim.
--
-- Key Features:
-- - **Formatter and Linter Integration**: Easily integrates a wide range of formatters and
--   linters, configurable on a per-filetype basis.
-- - **Automatic Installation**: Uses `mason-null-ls` to ensure necessary dependencies like
--   `clang-format` and `prettier` are installed, maintaining consistency across environments.
-- - **Diagnostics Integration**: Adds external diagnostics sources (e.g. `checkmake`).
--
-- Configuration Options:
-- - **Sources**: Defines specific formatters and linters, such as `clang-format` for C/C++,
--   `prettier` for JavaScript/HTML, and `ruff` for Python.
-- - **Formatting**: Disabled here (moved to conform.nvim).
-- - **Debugging**: Optional debug mode for `none-ls`, accessible via `:NullLsLog`.
--
-- Usage Notes:
-- - Run `:Mason` to view and install other tools as needed.
-- - Format files manually with `:lua vim.lsp.buf.format()` or rely on auto-format on save.
-- - Integrate additional formatters/linters as needed for other file types.
--
-- This setup provides a powerful and customizable C development environment in Neovim, with
-- support for various formatters and tools to maintain clean, consistent code.

return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    -- Note: mason-tool-installer handles tool installation (configured in lsp.lua)
  },
  config = function()
    local null_ls = require 'null-ls'
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- Formatters & linters are automatically installed via mason-tool-installer in lsp.lua

    local sources = {
      diagnostics.checkmake,
    }

    null_ls.setup {
      sources = sources,
    }
  end,
}
