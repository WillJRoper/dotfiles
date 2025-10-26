return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  -- See `:help gitsigns` to understand what the configuration keys do
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
    signs_staged = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
    },
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']C', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Jump to next git [c]hange' })

      map('n', '[C', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Jump to previous git [c]hange' })

      -- Actions
      -- visual mode
      map('v', '<leader>ghs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[G]it [h]unk [s]tage' })
      map('v', '<leader>ghr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[G]it [h]unk [r]eset' })
      
      -- Hunk operations
      map('n', '<leader>ghs', gitsigns.stage_hunk, { desc = '[G]it [h]unk [s]tage' })
      map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = '[G]it [h]unk [r]eset' })
      map('n', '<leader>ghu', gitsigns.undo_stage_hunk, { desc = '[G]it [h]unk [u]ndo stage' })
      map('n', '<leader>ghp', gitsigns.preview_hunk, { desc = '[G]it [h]unk [p]review' })
      
      -- Buffer operations (no 'h' prefix)
      map('n', '<leader>gS', gitsigns.stage_buffer, { desc = '[G]it [S]tage buffer' })
      map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[G]it [R]eset buffer' })
      
      -- Blame and diff
      map('n', '<leader>gb', gitsigns.blame_line, { desc = '[G]it [b]lame line' })
      map('n', '<leader>gd', gitsigns.diffthis, { desc = '[G]it [d]iff against index' })
      map('n', '<leader>gD', function()
        gitsigns.diffthis '@'
      end, { desc = '[G]it [D]iff against last commit' })
      
      -- Toggles
      map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = '[G]it [t]oggle [b]lame line' })
      map('n', '<leader>gtD', gitsigns.toggle_deleted, { desc = '[G]it [t]oggle [D]eleted' })
    end,
  },
}
