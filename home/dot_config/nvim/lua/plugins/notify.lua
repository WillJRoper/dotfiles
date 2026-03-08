-- Plugin: nvim-notify
-- URL: https://github.com/rcarriga/nvim-notify
--
-- Description:
-- `nvim-notify` is a Neovim plugin that provides a clean and customizable notification
-- system for Neovim. It replaces the default notification system with a more visually
-- appealing, floating UI. The notifications are highly configurable, allowing you to
-- adjust the appearance, animations, and integrations with other plugins.
--
-- Key Features:
-- - **Customizable Notifications**: Modify colors, icons, and styles for notifications.
-- - **Animation Support**: Provides fade in/out animations for a smooth notification experience.
-- - **Integration with Other Plugins**: Can be used by other plugins (like `noice.nvim`)
--   for notifications, making it the main notification handler.
-- - **Persistent History**: Retain notification history that can be viewed later.
--
-- Configuration Options:
-- - **timeout**: Duration (in milliseconds) for which notifications are shown.
-- - **stages**: Defines the animation stages for showing and hiding notifications.
-- - **background_colour**: Background color for notifications.
-- - **fps**: Frames per second for animations, providing a smooth visual experience.
-- - **icons**: Customize icons for different types of notifications (e.g., info, warn, error).
--
-- Usage Notes:
-- - Access recent notifications with `<leader>nh` (or your own key mapping).
-- - Combine `nvim-notify` with plugins like `noice.nvim` to handle messages consistently.
-- - You can use the `require('notify')` function in your own configurations to trigger notifications.

return {
  'rcarriga/nvim-notify',
  config = function()
    local notify = require 'notify'

    -- Setup Notify with options to match the Catppuccin theme
    notify.setup {
      -- Define the timeout for notifications
      timeout = 2000, -- Show notifications for 3 seconds
      -- Enable smooth animations with fade-in/out stages
      stages = 'slide',
      -- Set the background color to match Catppuccin
      background_colour = '#1e1e2e', -- Replace with your preferred Catppuccin background
      -- Adjust the FPS for animations
      fps = 60,
      -- Customize icons for notification levels
      icons = {
        ERROR = '',
        WARN = '',
        INFO = '',
        DEBUG = '',
        TRACE = '✎',
      },
      -- Set up colors to match Catppuccin palette
      render = 'default',
      -- Styles for different levels of notifications
      level_styles = {
        ERROR = { fg = '#f38ba8', bg = '#1e1e2e' }, -- Error notifications
        WARN = { fg = '#fab387', bg = '#1e1e2e' }, -- Warning notifications
        INFO = { fg = '#89b4fa', bg = '#1e1e2e' }, -- Info notifications
        DEBUG = { fg = '#94e2d5', bg = '#1e1e2e' }, -- Debug notifications
        TRACE = { fg = '#f5c2e7', bg = '#1e1e2e' }, -- Trace notifications
      },
    }

    -- Set nvim-notify as the default notification handler
    vim.notify = notify

    -- Notification management keymaps
    vim.keymap.set('n', '<leader>nn', function()
      notify.dismiss({ silent = true, pending = true })
    end, { desc = '[N]otifications dismiss [N]ow' })
    
    vim.keymap.set('n', '<leader>nh', function()
      require('telescope').extensions.notify.notify()
    end, { desc = '[N]otifications [H]istory' })
    
    vim.keymap.set('n', '<leader>nm', function()
      require('telescope.builtin').command_history()
    end, { desc = '[N]otifications [M]essage history' })
    
    vim.keymap.set('n', '<leader>nc', function()
      vim.cmd('messages clear')
      notify('Message history cleared', vim.log.levels.INFO)
    end, { desc = '[N]otifications [C]lear messages' })
    
    vim.keymap.set('n', '<leader>ns', function()
      local messages = vim.split(vim.fn.execute('messages'), '\n')
      local recent_messages = {}
      
      -- Get last 20 messages (or all if less than 20)
      local start_idx = math.max(1, #messages - 19)
      for i = start_idx, #messages do
        if messages[i] and messages[i] ~= '' then
          table.insert(recent_messages, messages[i])
        end
      end
      
      if #recent_messages == 0 then
        notify('No recent messages', vim.log.levels.INFO)
        return
      end
      
      -- Create floating window with recent messages
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, recent_messages)
      vim.api.nvim_set_option_value('modifiable', false, { buf = buf })
      vim.api.nvim_set_option_value('filetype', 'messages', { buf = buf })
      
      local width = math.min(vim.o.columns - 4, 100)
      local height = math.min(vim.o.lines - 4, #recent_messages + 2)
      
      local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - height) / 2),
        style = 'minimal',
        border = 'rounded',
        title = ' Recent Messages ',
        title_pos = 'center',
      })
      
      -- Set window options
      vim.api.nvim_set_option_value('wrap', false, { win = win })
      vim.api.nvim_set_option_value('cursorline', true, { win = win })
      
      -- Close with q or Escape
      vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true, noremap = true })
      vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', { buffer = buf, silent = true, noremap = true })
    end, { desc = '[N]otifications [S]how recent' })
    
    vim.keymap.set('n', '<leader>nv', function()
      vim.cmd('messages')
    end, { desc = '[N]otifications [V]iew all messages' })
    
    vim.keymap.set('n', '<leader>nt', function()
      -- Test notification with different levels
      notify('Test INFO notification', vim.log.levels.INFO)
      vim.defer_fn(function()
        notify('Test WARN notification', vim.log.levels.WARN)
      end, 1000)
      vim.defer_fn(function()
        notify('Test ERROR notification', vim.log.levels.ERROR)
      end, 2000)
    end, { desc = '[N]otifications [T]est' })
  end,
}
