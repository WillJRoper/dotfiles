-- Plugin: vim-bbye
-- URL: https://github.com/moll/vim-bbye
--
-- Description:
-- `vim-bbye` provides commands to delete buffers without closing their associated
-- windows, preserving the layout and allowing you to continue working seamlessly.
-- This is especially useful when managing multiple split windows, as it only closes
-- the buffer while keeping the Neovim window layout intact.
--
-- Key Features:
-- - **:Bdelete**: Delete the current buffer without closing the window, preventing
--   disruption to your layout.
-- - **:Bwipeout**: Similar to `:bwipeout`, but preserves the window.
-- - **Mappings**: You can easily map `Bdelete` to a convenient keybinding for quick access.
--
-- Usage Notes:
-- - Use `:Bdelete` to close the current buffer while keeping the window open.
-- - Add a keybinding to quickly close buffers without impacting the window layout:
--   `vim.api.nvim_set_keymap('n', '<leader>q', ':Bdelete<CR>', { noremap = true, silent = true })`
-- - `vim-bbye` is highly compatible with plugins that manage buffers, such as bufferline plugins.
--
-- This setup is ideal for users who want more control over buffer management and need
-- to delete buffers while preserving their current window arrangement.

return {
  'moll/vim-bbye',
  config = function()
    -- Optional: Keybinding for closing the current buffer without closing the window
    vim.api.nvim_set_keymap(
      'n',
      '<leader>q',
      ':Bdelete<CR>',
      { noremap = true, silent = true }
    )
  end,
}
