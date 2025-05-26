-- Plugin: git-conflict.nvim
-- URL: https://github.com/akinsho/git-conflict.nvim
--
-- Description:
-- `git-conflict.nvim` is a Neovim plugin designed to help developers easily navigate
-- and resolve Git merge conflicts. The plugin detects conflict markers in files (e.g.,
-- `<<<<<`, `=====`, `>>>>>`) and provides commands to resolve conflicts by choosing
-- between the current branch ("ours"), the incoming branch ("theirs"), or combining both.
-- It also supports quick navigation between conflicts.
--
-- Key Features:
-- - **Conflict Detection**: Automatically highlights Git conflict markers, making them
--   easy to spot and resolve.
-- - **Quick Resolution Commands**: Commands to choose either the current branch's changes,
--   the incoming branch's changes, or both.
-- - **Conflict Navigation**: Quickly jump between conflicts in a file.
-- - **Automatic Setup**: Integrates seamlessly with Neovim’s buffer and LSP features,
--   making it easy to configure and use.
--
-- Commands:
-- - `:GitConflictChooseOurs`: Choose the current branch’s changes.
-- - `:GitConflictChooseTheirs`: Choose the incoming branch’s changes.
-- - `:GitConflictChooseBoth`: Combine both changes.
-- - `:GitConflictNextConflict` / `:GitConflictPrevConflict`: Jump to the next or previous conflict.
--
-- Usage Notes:
-- - Use `:GitConflictNextConflict` and `:GitConflictPrevConflict` to navigate conflicts.
-- - Resolve each conflict with the quick commands for a smooth conflict resolution workflow.
-- - This plugin can work alongside `gitsigns.nvim` and other Git tools in Neovim for
--   a comprehensive Git integration.

return {
  'akinsho/git-conflict.nvim',
  requires = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('git-conflict').setup {
      default_mappings = false, -- Disable built-in keybindings

      highlights = { -- Customize highlight groups for better visibility
        incoming = 'DiffAdd', -- Highlight for incoming branch change markers
        current = 'DiffText', -- Highlight for current branch change markers
        ancestor = 'DiffChange', -- Highlight for ancestor markers, if available
      },

      disable_diagnostics = true, -- Optionally disable diagnostics in conflicted files
      disable_on_untracked = false, -- Show conflict markers in untracked files as well
    }

    -- Optional: Keybindings for quick conflict resolution commands
    vim.keymap.set(
      'n',
      '<leader>go',
      ':GitConflictChooseOurs<CR>',
      { desc = 'Choose Current Change' }
    )
    vim.keymap.set(
      'n',
      '<leader>gi',
      ':GitConflictChooseTheirs<CR>',
      { desc = 'Choose Incoming Change' }
    )
    vim.keymap.set(
      'n',
      '<leader>gb',
      ':GitConflictChooseBoth<CR>',
      { desc = 'Choose Both Changes' }
    )
    vim.keymap.set(
      'n',
      '<leader>gn',
      ':GitConflictNextConflict<CR>',
      { desc = 'Next Conflict' }
    )
    vim.keymap.set(
      'n',
      '<leader>gp',
      ':GitConflictPrevConflict<CR>',
      { desc = 'Previous Conflict' }
    )
  end,
}
