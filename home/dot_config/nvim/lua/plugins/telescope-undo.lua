-- Plugin: telescope-undo.nvim
-- URL: https://github.com/debugloop/telescope-undo.nvim
--
-- Description:
-- `telescope-undo` extends Telescope with an interactive way to navigate the undo history.
-- This plugin offers a more modern interface than traditional undo tree tools by leveraging
-- the power of Telescope's fuzzy finder and preview capabilities, allowing you to preview
-- and revert to previous states in your editing history.
--
-- Features:
-- - Interactive Telescope-powered undo history, displaying a list of undo points with previews.
-- - Quickly navigate, preview, and restore to any point in the undo history.
-- - Integrates with Telescope for consistent UI and controls, including fuzzy search.
--
-- Usage Notes:
-- - Bind `<leader>u` (or any key of choice) to the `:Telescope undo` command to access the
--   undo history directly from the Telescope interface. Once open, you can scroll through
--   previous changes, preview them, and press `<CR>` to restore a selected state.
-- - For the best experience, ensure that `undofile` is enabled in Neovim to retain
--   undo history across sessions. This can be set globally in your configuration.

return {
  'debugloop/telescope-undo.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('telescope').load_extension 'undo'
  end,
}
