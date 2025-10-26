-- Plugin: virt-column.nvim
-- URL: https://github.com/lukas-reineke/virt-column.nvim
--
-- Description:
-- `virt-column.nvim` is a Neovim plugin that places a virtual column at a specified
-- character length. This can be useful for indicating preferred line lengths, such as
-- the 79th column. Unlike the `ColorColumn` feature, `virt-column.nvim` allows for
-- more subtle, customizable character choices and better control over the column's
-- appearance.
--
-- Features:
-- - Define a virtual column with a customizable character, separate from `ColorColumn`.
-- - Supports any character for the column, allowing for thinner or dashed indicators.
-- - Integrates easily and works well with modern Neovim configurations.
--
-- Configuration Options:
-- - `virtcolumn`: Set the position of the virtual column (e.g., "79").
-- - `char`: Customize the character used for the column (e.g., '│' or '┆').
--
-- Usage Notes:
-- - This configuration file sets the column at the 79th character with a thin vertical bar.
-- - Adjust the `char` value if you want a different character for the column guide.
-- - To enable or disable this plugin for specific file types, use Neovim's autocommands.

return {
  'lukas-reineke/virt-column.nvim',
  config = function()
    require('virt-column').setup {
      char = '│', -- Customize this character (e.g., "│" for a thin line, "┆" for a dotted line)
      virtcolumn = '79', -- Set the column at the 79th character
    }
  end,
}
