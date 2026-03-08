-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set('n', '<C-s>', '<cmd> w <CR>', opts)

-- save file without auto-formatting
vim.keymap.set('n', '<leader>ww', '<cmd>noautocmd w <CR>', opts)

-- quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', opts)

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>x', ':Bdelete!<CR>', opts) -- close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- new buffer

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts) -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts) -- split window horizontally
vim.keymap.set('n', '<leader>|', '<C-w>v', opts) -- split window vertically (alternative)
vim.keymap.set('n', '<leader>-', '<C-w>s', opts) -- split window horizontally (alternative)
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal width & height
vim.keymap.set('n', '<leader>wc', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set(
  'n',
  '[d',
  function()
    vim.diagnostic.jump { count = -1 }
  end,
  { desc = 'Go to previous diagnostic message' }
)
vim.keymap.set(
  'n',
  ']d',
  function()
    vim.diagnostic.jump { count = 1 }
  end,
  { desc = 'Go to next diagnostic message' }
)
vim.keymap.set(
  'n',
  '<leader>d',
  vim.diagnostic.open_float,
  { desc = 'Open floating diagnostic message' }
)
vim.keymap.set(
  'n',
  '<leader>q',
  vim.diagnostic.setloclist,
  { desc = 'Open diagnostics list' }
)

-- Return to dashboard
vim.keymap.set('n', '<leader>db', '<cmd>Alpha<CR>', opts)

-- Invoke Neogit with the magit muscle memory
vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<CR>', opts)

-- Telescope undo tree
vim.keymap.set('n', '<leader>u', '<cmd>Telescope undo<CR>', opts)

-- Better terminal navigation
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h', opts)
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j', opts)
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k', opts)
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l', opts)

-- Modern text manipulation
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts) -- Move text down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts) -- Move text up

-- Better escape from insert mode
vim.keymap.set('i', '<C-c>', '<Esc>', opts)

-- Quick fix/location list navigation
vim.keymap.set('n', '<leader>co', '<cmd>copen<CR>', { desc = 'Open quickfix list' })
vim.keymap.set('n', '<leader>cc', '<cmd>cclose<CR>', { desc = 'Close quickfix list' })
vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { desc = 'Next quickfix item' })
vim.keymap.set('n', '[q', '<cmd>cprev<CR>', { desc = 'Previous quickfix item' })

-- My functions mappings
local comment_tools = require 'utils.myfunctions.comments'
vim.keymap.set(
  'n',
  '<leader>mc',
  comment_tools.align_yaml_comments,
  { desc = 'Align end of line comments' }
)
