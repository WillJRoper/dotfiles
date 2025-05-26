-- Plugin: none-ls
-- URL: https://github.com/nvimtools/none-ls.nvim
--
-- Description:
-- `none-ls` is a versatile Neovim plugin that allows you to integrate various formatters,
-- linters, and code analysis tools into Neovim using the Language Server Protocol (LSP).
-- This setup enhances the C development experience by adding support for `clang-format` to
-- format C/C++ code, working alongside `clangd` for real-time diagnostics.
--
-- Key Features:
-- - **Formatter and Linter Integration**: Easily integrates a wide range of formatters and
--   linters, configurable on a per-filetype basis.
-- - **Automatic Installation**: Uses `mason-null-ls` to ensure necessary dependencies like
--   `clang-format` and `prettier` are installed, maintaining consistency across environments.
-- - **Auto-Formatting on Save**: Automatically formats files on save with `clang-format` for
--   C files, `prettier` for JavaScript/HTML, and more.
-- - **Extra Formatting Options**: Customize `clang-format` settings to tailor indentation
--   and other style preferences.
--
-- Configuration Options:
-- - **Sources**: Defines specific formatters and linters, such as `clang-format` for C/C++,
--   `prettier` for JavaScript/HTML, and `ruff` for Python.
-- - **Auto Formatting**: Configures an autocmd to automatically format the file on save,
--   maintaining a consistent coding style.
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
    'jayp0521/mason-null-ls.nvim', -- ensure dependencies are installed
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting -- to setup formatters
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- Formatters & linters for mason to install
    require('mason-null-ls').setup {
      ensure_installed = {
        'prettier', -- ts/js formatter
        'stylua', -- lua formatter
        'eslint_d', -- ts/js linter
        'shfmt', -- Shell formatter
        'checkmake', -- linter for Makefiles
        'ruff', -- Python linter and formatter
        'clang-format', -- C/C++ formatter
      },
      automatic_installation = true,
    }

    local sources = {
      diagnostics.checkmake,
      formatting.prettier.with {
        filetypes = { 'html', 'json', 'yaml', 'markdown' },
      },
      formatting.stylua,
      formatting.shfmt.with { args = { '-i', '4' } },
      formatting.terraform_fmt,
      require('none-ls.formatting.ruff').with {
        extra_args = { '--extend-select', 'I' },
      },
      require 'none-ls.formatting.ruff_format',

      -- Add clang-format for C files
      formatting.clang_format.with {
        filetypes = { 'c', 'h', 'cu', 'cpp', 'hpp', 'objc', 'objcpp' },
        extra_args = { '--style=file', '--fallback-style=LLVM' }, -- Use style file, fallback to LLVM
      },
    }

    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      sources = sources,
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false }
            end,
          })
        end
      end,
    }
  end,
}
