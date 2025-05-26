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
  end,
}
