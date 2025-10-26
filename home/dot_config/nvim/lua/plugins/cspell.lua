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

    -- Add cspell to none-ls sources
    local null_ls = require('null-ls')
    
    -- Register cspell as both diagnostic and code action source
    null_ls.register({
      name = 'cspell',
      sources = {
        cspell.diagnostics.with(cspell_config),
        cspell.code_actions.with(cspell_config),
      },
    })

    -- Keymaps for spell checking
    vim.keymap.set('n', '<leader>sa', vim.lsp.buf.code_action, { desc = '[S]pell [A]ctions (cspell)' })
    
    -- Quick navigation to next/previous spell errors
    vim.keymap.set('n', '<leader>sn', function()
      vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.HINT })
    end, { desc = '[S]pell [N]ext error' })
    
    vim.keymap.set('n', '<leader>sp', function()
      vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.HINT })
    end, { desc = '[S]pell [P]revious error' })

    -- Toggle spell checking diagnostics
    vim.keymap.set('n', '<leader>st', function()
      local clients = vim.lsp.get_active_clients()
      for _, client in pairs(clients) do
        if client.name == 'null-ls' then
          if vim.diagnostic.is_disabled() then
            vim.diagnostic.enable()
            print('Spell checking enabled')
          else
            vim.diagnostic.disable()
            print('Spell checking disabled')
          end
          break
        end
      end
    end, { desc = '[S]pell [T]oggle' })

    -- Show all spell errors in current buffer
    vim.keymap.set('n', '<leader>sl', function()
      vim.diagnostic.setloclist({ severity = vim.diagnostic.severity.HINT })
    end, { desc = '[S]pell [L]ist errors' })
  end,
}