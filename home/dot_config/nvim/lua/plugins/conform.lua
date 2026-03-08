-- Plugin: conform.nvim
-- URL: https://github.com/stevearc/conform.nvim
--
-- Formatting is handled here (including format-on-save). Use `<leader>ww` to save without
-- triggering formatting (`:noautocmd w`).

return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>lf',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      desc = 'Format buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- `:noautocmd w` bypasses this.
      return {
        bufnr = bufnr,
        lsp_fallback = true,
        timeout_ms = 3000,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_fix', 'ruff_format' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      zsh = { 'shfmt' },
      terraform = { 'terraform_fmt' },
      tf = { 'terraform_fmt' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      objc = { 'clang_format' },
      objcpp = { 'clang_format' },
      cuda = { 'clang_format' },
      html = { 'prettier' },
      json = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      css = { 'prettier' },
      scss = { 'prettier' },
      less = { 'prettier' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      vue = { 'prettier' },
      svelte = { 'prettier' },
    },
    formatters = {
      shfmt = {
        prepend_args = { '-i', '4' },
      },
      clang_format = {
        prepend_args = { '--style=file', '--fallback-style=llvm' },
      },
      ruff_fix = {
        args = {
          'check',
          '--fix',
          '--extend-select',
          'I',
          '--stdin-filename',
          '$FILENAME',
          '-',
        },
      },
    },
  },
}
