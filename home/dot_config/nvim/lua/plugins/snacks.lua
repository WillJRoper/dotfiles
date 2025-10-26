-- Plugin: snacks.nvim (minimal setup)
-- URL: https://github.com/folke/snacks.nvim
--
-- Description:
-- Using only the scope detection and words (LSP references) features from snacks.nvim
-- for better code navigation and context awareness.

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    -- Only enable the features we want
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    notifier = { enabled = false },
    quickfile = { enabled = false },
    statuscolumn = { enabled = false },
    terminal = { enabled = false },
    
    -- Enable scope detection and navigation
    scope = {
      enabled = true,
      -- Scope detection based on treesitter or indent
      treesitter = {
        -- Highlight the scope of the current cursor position
        enabled = true,
      },
      -- Add keymaps for scope navigation
      keys = {
        -- Jump to next/previous scope
        ["]s"] = { "next", desc = "Next scope" },
        ["[s"] = { "prev", desc = "Previous scope" },
      },
    },
    
    -- Enable LSP references highlighting
    words = {
      enabled = true,
      -- Auto-show LSP references for word under cursor
      debounce = 200, -- milliseconds to wait before showing references
      -- Only show references when cursor is idle
      modes = { "n" }, -- only in normal mode
    },
  },
  config = function(_, opts)
    require('snacks').setup(opts)
    
    -- Additional keymaps for scope text objects
    vim.keymap.set({ 'o', 'x' }, 'is', function()
      require('snacks.scope').textobject()
    end, { desc = 'Inner scope' })
    
    vim.keymap.set({ 'o', 'x' }, 'as', function()
      require('snacks.scope').textobject(true)
    end, { desc = 'Around scope' })
  end,
}