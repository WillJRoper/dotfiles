return {
  'catppuccin/nvim',
  name = 'catppuccin-mocha',
  priority = 1000,
  config = function()
    -- Load the Catppuccin theme
    require('catppuccin').setup {
      transparent_background = true, -- General background is fully transparent
    }
    vim.cmd.colorscheme 'catppuccin-mocha'

    -- Set semi-transparent background for overlay windows (e.g., floating windows, popups)
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1d2230', fg = '#a0a9cb' }) -- Slightly opaque for floating windows
    vim.api.nvim_set_hl(0, 'Pmenu', { bg = '#1d2230', fg = '#a0a9cb' }) -- Popup menu with less transparency
    vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#394260', fg = '#a3aed2' }) -- Popup menu selected item
  end,
}
