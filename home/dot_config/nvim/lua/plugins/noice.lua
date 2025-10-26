-- Plugin: noice.nvim
-- URL: https://github.com/folke/noice.nvim
--
-- Description:
-- `noice.nvim` is a plugin that improves Neovim's command-line and message handling, providing
-- a cleaner, more modern interface. It replaces the default command line, messages, notifications,
-- and search results with a floating, customizable UI. This makes it easier to interact with
-- Neovim, especially when running commands, viewing messages, and navigating search results.
--
-- Key Features:
-- - **Command Line Replacement**: Replaces the command line with a floating UI, allowing for a
--   more flexible and responsive command-line experience.
-- - **Notifications**: Displays notifications in a compact, non-intrusive manner.
-- - **Floating Search Results**: Enhances the search experience by showing floating results.
-- - **Integrated Popup Menus**: Shows completion and suggestion menus with a modern look.
-- - **Customizable UI**: Offers customization options to match the aesthetics and needs of your Neovim setup.
--
-- Configuration Options:
-- - **cmdline**: Customize the appearance and behavior of the command line.
-- - **lsp**: Integrates with Neovim’s built-in LSP to show messages, diagnostics, and notifications.
-- - **popupmenu**: Controls the popup menu appearance, providing a floating or inline completion menu.
-- - **messages**: Customize the format and location of notifications and messages.
--
-- Usage Notes:
-- - `noice.nvim` integrates well with other plugins like `nvim-notify` for notifications and LSP
--   features, creating a unified experience for interacting with Neovim.
-- - You can toggle the Noice UI on/off as needed for a more traditional experience or modern UI.
-- - Combine it with `lualine` or `nvim-cmp` for a cohesive, polished interface in Neovim.

return {
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim', -- Required UI library for noice
    'rcarriga/nvim-notify', -- Optional for improved notifications
  },
  config = function()
    require('noice').setup {
      cmdline = {
        enabled = true, -- Enables the floating command line
        format = {
          cmdline = { pattern = '^:', icon = ' ', lang = 'vim' },
          search_down = {
            kind = 'search',
            pattern = '^/',
            icon = ' ↓',
            lang = 'regex',
          },
          search_up = {
            kind = 'search',
            pattern = '^%?',
            icon = ' ↑',
            lang = 'regex',
          },
        },
      },
      lsp = {
        -- Integrates LSP messages with noice
        progress = { enabled = true },
        hover = { enabled = true, view = 'popup' }, -- Show hover information in a popup
        signature = { enabled = true, auto_open = { enabled = true } },
        documentation = { view = 'hover' },         -- Use hover view for LSP documentation
      },
      popupmenu = {
        -- Shows completion suggestions in a floating window
        enabled = true,
        backend = 'nui', -- Options: "nui" or "cmp"
      },
      messages = {
        enabled = true, -- Enable message handling for noice
        view = 'mini',  -- Minimal message view at the bottom
      },
      notify = {
        enabled = true, -- Enable notifications via nvim-notify
        view = 'notify',
      },
      views = {
        -- Customize the various UI views
        cmdline_popup = {
          position = { row = '40%', col = '50%' },
          size = { width = 60, height = 'auto' },
          border = { style = 'rounded' },
          win_options = {
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
          },
        },
        popupmenu = {
          position = { row = '60%', col = '50%' },
          size = { width = 60, height = 10 },
          border = { style = 'rounded' },
          win_options = {
            winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
          },
        },
      },
      presets = {
        -- Activate predefined styles
        long_message_to_split = true, -- Split long messages for better readability
        lsp_doc_border = true,        -- Add borders to LSP hover docs
        bottom_search = false,        -- Show search bar at the bottom instead of popup
      },
      throttle = 1000 / 60,           -- Throttle updates for better performance
    }

    -- Optional keybindings for Noice (replace with your preferred mappings)
    vim.keymap.set('n', '<leader>nl', function()
      require('noice').cmd 'last'
    end, { desc = 'Show last message' })
    vim.keymap.set('n', '<leader>nH', function()
      require('noice').cmd 'history'
    end, { desc = 'Show noice message history' })
    vim.keymap.set('n', '<leader>nd', function()
      require('noice').cmd 'dismiss'
    end, { desc = 'Dismiss all messages' })
  end,
}
