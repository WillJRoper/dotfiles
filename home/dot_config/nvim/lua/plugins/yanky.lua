-- Plugin: yanky.nvim
-- URL: https://github.com/gbprod/yanky.nvim
--
-- Description:
-- `yanky.nvim` enhances the default yank and paste functionality in Neovim by providing
-- a persistent yank history that you can cycle through. This plugin allows you to paste
-- the last yanked text and then use keybindings to browse backward and forward through
-- previous yanks, making it easy to find and paste exactly what you need.
--
-- Features:
-- - Persistent yank history that you can navigate through, similar to clipboard managers.
-- - Keybindings to cycle back and forth through past yanks for quick access.
-- - Integrates seamlessly with Neovim's native yank and paste operations.
--
-- Configuration Options:
-- - The default setup allows you to paste with `p` or `P` and cycle backward with `<C-p>`
--   and forward with `<C-n`.
-- - Customizable settings for handling different paste behaviors, like pasting after or before
--   the cursor position.
--
-- Usage Notes:
-- - To paste the most recent yank, press `p` (after cursor) or `P` (before cursor).
-- - Once pasted, you can press `<C-p>` to cycle backward through previous yanks, and `<C-n>`
--   to cycle forward.
-- - This configuration does not interfere with visual mode mappings that you may have for `p`,
--   allowing you to keep behavior like `"p` for pasting without overwriting the register.

return {
  'gbprod/yanky.nvim',
  config = function()
    require('yanky').setup {}

    -- Normal mode keybindings for pasting and cycling through yank history
    vim.api.nvim_set_keymap('n', 'P', '<Plug>(YankyPutAfter)', {})
    vim.api.nvim_set_keymap('n', 'p', '<Plug>(YankyPutBefore)', {})
    vim.api.nvim_set_keymap('n', '<C-p>', '<Plug>(YankyCycleBackward)', {})
    vim.api.nvim_set_keymap('n', '<C-n>', '<Plug>(YankyCycleForward)', {})
  end,
}
