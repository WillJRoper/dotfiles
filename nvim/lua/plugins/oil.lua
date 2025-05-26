-- Plugin: oil.nvim
-- URL: https://github.com/stevearc/oil.nvim
--
-- Description:
-- `oil.nvim` is a modern file explorer for Neovim, designed to provide an
-- intuitive and efficient way to browse, create, delete, and rename files and directories
-- directly within Neovim. With `oil.nvim`, you can navigate your file structure quickly,
-- leveraging native Neovim commands and bindings to manage files seamlessly.
--
-- Key Features:
-- - **File and Directory Management**: Easily create, rename, delete, and move files and folders.
-- - **Navigation**: Quickly open files and folders, with built-in key mappings for smooth navigation.
-- - **Floating Window**: Optionally open the file explorer in a floating window for a minimalistic feel.
-- - **Git Integration**: Displays Git status indicators, showing changes within the file tree.
--
-- Configuration Options:
-- - **floating**: Opens the explorer in a floating window, saving screen real estate.
-- - **icons**: Customize icons for files and folders based on their status (e.g., open, closed).
-- - **use_default_keymaps**: Uses default key mappings for essential functions like opening, deleting, and creating files.
-- - **keymaps**: Define custom key mappings for actions like opening, renaming, and closing the explorer.
--
-- Usage Notes:
-- - Use the default key mapping (usually `<leader>e`) to toggle the file explorer.
-- - To navigate, use arrow keys or `hjkl` and press `Enter` to open files.
-- - Manage files directly within the explorer by using commands for new files, deletion, and renaming.
-- - `oil.nvim` integrates well with other Neovim plugins, creating a cohesive workflow for code navigation and editing.

return {
  'stevearc/oil.nvim',
  config = function()
    require('oil').setup {
      view_options = {
        -- Show hidden files by default
        show_hidden = true,
      },
      keymaps = {
        -- Use `Enter` to open files and `Backspace` to navigate up a directory
        ['<CR>'] = 'actions.select',
        ['<BS>'] = 'actions.parent',
        ['<C-s>'] = 'actions.preview', -- Preview file without opening
        ['<C-r>'] = 'actions.refresh', -- Refresh the file explorer
        ['-'] = 'actions.close', -- Close the oil explorer
        ['<C-h>'] = 'actions.toggle_hidden', -- Toggle hidden files
      },
      floating = {
        max_height = 0.8, -- Height of the floating window as a percentage of the screen height
        max_width = 0.8, -- Width of the floating window as a percentage of the screen width
        border = 'rounded', -- Border style for the floating window
      },
      use_default_keymaps = true, -- Enables default key mappings
      icons = {
        -- Customize icons for directories
        folder_closed = '',
        folder_open = '',
        file_default = '',
        git = {
          unstaged = '✗',
          staged = '✓',
          untracked = '?',
          renamed = '➜',
          deleted = '',
        },
      },
      delete_to_trash = true, -- Send deleted files to trash
    }

    -- Optional: Key mapping to toggle oil.nvim
    vim.keymap.set(
      'n',
      '-',
      require('oil').open,
      { desc = 'Toggle Oil File Explorer' }
    )
  end,
}
