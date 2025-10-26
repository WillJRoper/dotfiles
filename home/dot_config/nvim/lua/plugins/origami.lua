-- Plugin: nvim-origami
-- URL: https://github.com/chrisgrieser/nvim-origami
--
-- Description:
-- nvim-origami is a lightweight alternative to nvim-ufo that provides better
-- manual fold control. It uses LSP → Treesitter → Indent as fallback providers
-- and doesn't automatically recalculate folds on text changes.

return {
  'chrisgrieser/nvim-origami',
  event = 'BufReadPost',
  opts = {
    -- Keep folds closed when opening files
    keepFoldsAcrossSessions = true,
    -- Auto-fold imports and comments on file open
    pauseFoldsOnSearch = true,
    setupFoldKeymaps = true,
  },
  config = function(_, opts)
    require('origami').setup(opts)

    -- Restore fold keymaps similar to UFO setup
    vim.keymap.set('n', 'zR', function()
      require('origami').openAllFolds()
    end, { desc = 'Open all folds' })
    
    vim.keymap.set('n', 'zM', function()
      require('origami').closeAllFolds()
    end, { desc = 'Close all folds' })

    -- Custom fold navigation that only jumps to visible (closed) folds
    local function next_closed_fold(direction)
      local view = vim.fn.winsaveview()
      local start_line = view.lnum
      local current_line = start_line
      local last_line = 0
      local found_closed = false
      
      while current_line ~= last_line and not found_closed do
        vim.cmd('normal! z' .. direction)
        last_line = current_line
        current_line = vim.fn.line('.')
        found_closed = vim.fn.foldclosed(current_line) >= 0
      end
      
      if not found_closed then
        vim.fn.winrestview(view)
      end
    end

    -- Fold navigation - only jumps to closed/visible folds
    vim.keymap.set('n', '<leader>fn', function()
      next_closed_fold('j')
    end, { desc = '[F]old jump to [n]ext closed fold' })
    
    vim.keymap.set('n', '<leader>fp', function()
      next_closed_fold('k')
    end, { desc = '[F]old jump to [p]revious closed fold' })
    
    -- Fold manipulation
    vim.keymap.set('n', '<leader>ff', 'za', { desc = '[F]old toggle at cursor' })
    vim.keymap.set('n', '<leader>fo', 'zo', { desc = '[F]old [O]pen at cursor' })
    vim.keymap.set('n', '<leader>fc', 'zc', { desc = '[F]old [C]lose at cursor' })
    
    -- Fold levels
    vim.keymap.set('n', '<leader>f0', function()
      vim.opt.foldlevel = 0
    end, { desc = '[F]old level 0 (force closed)' })
    vim.keymap.set('n', '<leader>f1', function()
      vim.opt.foldlevel = 1
    end, { desc = '[F]old level 1' })
    vim.keymap.set('n', '<leader>f9', function()
      vim.opt.foldlevel = 99
    end, { desc = '[F]old level 99 (allow all)' })
  end,
}