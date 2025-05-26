-- Plugin: cspell.nvim
-- URL: https://github.com/davidmh/cspell.nvim
--
-- Description:
-- `cspell.nvim` is a plugin that integrates the CSpell CLI tool into Neovim, providing
-- inline spell checking for code and natural language. Using `none-ls.nvim`, it offers
-- diagnostics and code actions for fixing spelling mistakes efficiently. With support for
-- custom dictionaries and project-specific settings, it's an excellent tool for maintaining
-- clean and professional codebases.
--
-- Key Features:
-- - **Inline Spell Checking**: Highlights spelling mistakes in comments, strings, and other textual areas.
-- - **Context Aware**: Checks spelling without interfering with code structure.
-- - **Custom Dictionaries**: Supports personal and project-specific dictionaries via `cspell.json`.
-- - **Code Actions**: Provides quick actions for adding words to dictionaries or ignoring specific words.
-- - **Integration with `none-ls`**: Seamlessly integrates into the Neovim diagnostics system.
--
-- Usage Notes:
-- - Install the `cspell` CLI globally with `npm install -g cspell`.
-- - Create a `cspell.json` file in your project root for custom configuration.
-- - Use keybindings for quick fixes (e.g., add words to dictionaries or ignore them).
return {
  'davidmh/cspell.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required utility library for Lua plugins
    'nvimtools/none-ls.nvim', -- Required for diagnostics and code actions
  },
  config = function()
    local null_ls = require 'null-ls' -- Correct module name
    local cspell = require 'cspell'

    -- Configure null-ls with CSpell sources
    null_ls.setup {
      sources = {
        cspell.diagnostics.with {
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.INFO -- Set diagnostics to INFO level
          end,
        },
        cspell.code_actions, -- Enable quick fixes for spelling issues
      },
    }

    -- Keybindings for CSpell
    vim.keymap.set('n', '<leader>cs', function()
      vim.lsp.buf.code_action {
        filter = function(action)
          return action.title:match 'Add to CSpell'
        end,
      }
    end, { desc = 'Add word to CSpell dictionary' })

    vim.keymap.set('n', '<leader>ci', function()
      vim.lsp.buf.code_action {
        filter = function(action)
          return action.title:match 'Ignore word'
        end,
      }
    end, { desc = 'Ignore word in CSpell' })
  end,
}
