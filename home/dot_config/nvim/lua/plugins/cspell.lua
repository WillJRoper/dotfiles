-- Plugin: cspell.nvim
-- URL: https://github.com/davidmh/cspell.nvim
--
-- Description:
-- cspell.nvim provides comprehensive spell checking for code and text files using
-- the cspell CLI tool. It integrates with none-ls to provide LSP-style diagnostics
-- and code actions for spell checking across all file types.

return {
  'davidmh/cspell.nvim',
  dependencies = { 'nvimtools/none-ls.nvim' },
  config = function()
    local cspell = require('cspell')
    
    -- Configure cspell with project-specific settings
    local cspell_config = {
      -- Custom configuration for better code spell checking
      config = {
        -- Use local dictionaries if available
        find_json = function()
          return vim.fn.expand('~/cspell.json')
        end,
      },
      -- Set diagnostic severity to hint to avoid being too intrusive
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity.HINT
      end,
    }

    -- Add cspell sources to none-ls
    local null_ls = require('null-ls')
    null_ls.register(cspell.diagnostics.with(cspell_config))
    null_ls.register(cspell.code_actions.with(cspell_config))

    -- Keymaps for spell checking (moved off `<leader>s` to avoid Telescope conflicts)
    vim.keymap.set('n', '<leader>zc', vim.lsp.buf.code_action, { desc = 'Spell: Code actions (cspell)' })
    vim.keymap.set('n', '<leader>zs', vim.lsp.buf.code_action, { desc = 'Spell: Suggestions (cspell)' })

    vim.keymap.set('n', '<leader>zn', function()
      vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.HINT }
    end, { desc = 'Spell: Next error' })

    vim.keymap.set('n', '<leader>zp', function()
      vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.HINT }
    end, { desc = 'Spell: Previous error' })

    vim.keymap.set('n', '<leader>zt', function()
      local has_none_ls = false
      for _, client in ipairs(vim.lsp.get_clients()) do
        if client.name == 'null-ls' or client.name == 'none-ls' then
          has_none_ls = true
          break
        end
      end

      if not has_none_ls then
        vim.notify('none-ls not active (cspell disabled)', vim.log.levels.WARN)
        return
      end

      local enabled
      if vim.diagnostic.is_enabled then
        enabled = vim.diagnostic.is_enabled()
      else
        enabled = vim.g.__cspell_diagnostics_enabled ~= false
      end

      if enabled then
        vim.diagnostic.disable()
        vim.g.__cspell_diagnostics_enabled = false
        vim.notify('Spell diagnostics disabled', vim.log.levels.INFO)
      else
        vim.diagnostic.enable()
        vim.g.__cspell_diagnostics_enabled = true
        vim.notify('Spell diagnostics enabled', vim.log.levels.INFO)
      end
    end, { desc = 'Spell: Toggle diagnostics' })

    vim.keymap.set('n', '<leader>zl', function()
      vim.diagnostic.setloclist { severity = vim.diagnostic.severity.HINT }
    end, { desc = 'Spell: List errors' })
  end,
}
