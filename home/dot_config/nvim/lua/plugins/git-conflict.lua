-- Plugin: git-conflict.nvim
-- URL: https://github.com/akinsho/git-conflict.nvim
--
-- Description:
-- `git-conflict.nvim` is a Neovim plugin designed to help developers easily navigate
-- and resolve Git merge conflicts. The plugin detects conflict markers in files (e.g.,
-- `<<<<<`, `=====`, `>>>>>`) and provides commands to resolve conflicts by choosing
-- between the current branch ("ours"), the incoming branch ("theirs"), or combining both.
-- It also supports quick navigation between conflicts.

-- Load and configure plugin
return {
  'akinsho/git-conflict.nvim',
  version = '*',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('git-conflict').setup({
      default_mappings = false, -- disable default mappings
    })

    -- Custom keymaps under <leader>g prefix
    vim.keymap.set('n', '<leader>gn', '<Plug>(git-conflict-next-conflict)', { desc = '[G]it conflict [n]ext' })
    vim.keymap.set('n', '<leader>gp', '<Plug>(git-conflict-prev-conflict)', { desc = '[G]it conflict [p]revious' })
    vim.keymap.set('n', '<leader>gco', '<Plug>(git-conflict-ours)', { desc = '[G]it [c]onflict choose [o]urs' })
    vim.keymap.set('n', '<leader>gct', '<Plug>(git-conflict-theirs)', { desc = '[G]it [c]onflict choose [t]heirs' })
    vim.keymap.set('n', '<leader>gcb', '<Plug>(git-conflict-both)', { desc = '[G]it [c]onflict choose [b]oth' })
    vim.keymap.set('n', '<leader>gc0', '<Plug>(git-conflict-none)', { desc = '[G]it [c]onflict choose n[0]ne' })

    -- Optional: custom highlights for conflict regions
    vim.cmd [[
      highlight GitConflictCurrent guibg=#2e3440
      highlight GitConflictIncoming guibg=#3b4252
    ]]
  end,
}
