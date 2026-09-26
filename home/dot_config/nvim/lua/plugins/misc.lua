-- Standalone plugins with less than 10 lines of config go here
return {
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-neotest/neotest-python',
    },
    keys = {
      { '<leader>tn', function() require('neotest').run.run() end, desc = 'Test nearest' },
      { '<leader>tf', function() require('neotest').run.run(vim.fn.expand '%') end, desc = 'Test file' },
      { '<leader>ts', function() require('neotest').summary.toggle() end, desc = 'Test summary' },
      { '<leader>to', function() require('neotest').output.open { enter = true } end, desc = 'Test output' },
    },
    opts = {
      adapters = { 'neotest-python' },
      status = { virtual_text = true },
      output = { open_on_run = false },
    },
  },
  {
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },
  {
    -- Hints keybinds
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      triggers = {
        { '<auto>', mode = 'nxso' },
        { '<leader>', mode = { 'n', 'v' } },
      },
      spec = {
        { '<leader>a', group = '[A]I' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>n', group = '[N]otifications' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>g', group = '[G]it' },
        { '<leader>gh', group = '[G]it [H]unk' },
        { '<leader>gc', group = '[G]it [C]onflict' },
        { '<leader>gt', group = '[G]it [T]oggle' },
        { '<leader>x', group = 'Trouble' },
        { '<leader>l', group = '[L]SP' },
        { '<leader>o', group = '[O]penCode' },
        { '<leader>z', group = 'Spell' },
      },
    },
  },
  {
    -- Autoclose parentheses, brackets, quotes, etc.
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {},
  },
  {
    -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    -- High-performance color highlighter
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {},
  },
}
