return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  lazy = true,
  config = function()
    require('copilot').setup {
      -- Panel configuration (like autocompletion)
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = '[[',
          jump_next = ']]',
          accept = '<CR>',
          refresh = 'gr',
          open = '<M-CR>',
        },
        layout = {
          position = 'bottom', -- | top | left | right
          ratio = 0.4,
        },
      },

      -- Ghost autocompletion (gets in the way of LSP overlays)
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = '<M-a>',
          accept_word = '<M-l>',
          accept_line = '<M-j>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },

      -- Activate it almost everywhere
      filetypes = {
        ['*'] = true,
        ['dart'] = true,
        ['javascript'] = true,
        ['typescript'] = true,
        ['typescriptreact'] = true,
        ['typescript.tsx'] = true,
        ['lua'] = true,
        ['rust'] = true,
        ['go'] = true,
        ['php'] = true,
        ['python'] = true,
        ['html'] = true,
        ['markdown'] = true,
        ['yaml'] = true,
        ['makefile'] = true,
        ['cmake'] = true,
        ['cpp'] = true,
        ['c#'] = true,
        ['java'] = true,
        ['kotlin'] = true,
        ['swift'] = true,
        ['c'] = true,
        ['rust'] = true,
        ['java'] = true,
        ['javascript'] = true,

        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ['.'] = false,
      },
      copilot_node_command = 'node', -- Node.js version must be > 18.x
      server_opts_overrides = {},
    }
  end,
}
