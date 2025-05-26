-- Plugin: indent-blankline.nvim
-- URL: https://github.com/lukas-reineke/indent-blankline.nvim
--
-- Description:
-- This plugin adds vertical indentation guides to all lines, making code structure
-- more visible and easier to navigate, especially in deeply nested files.
-- It supports custom characters, colors, and integration with Neovim's built-in LSP
-- and Treesitter for context-aware indentation.
--
-- Features:
-- - Display indentation guides with customizable characters and colors.
-- - Configurable by file type, allowing exclusions for certain file types.
-- - Supports scope highlighting, marking the start and end of indentation blocks.
-- - Integrates with Treesitter for precise scope-based indentation in various languages.
--
-- Configuration Options:
-- - `char`: Character used for the indentation guides (default: '▏').
-- - `scope.show_start` and `scope.show_end`: Options to show scope markers at the
--   beginning or end of indentation blocks.
-- - `exclude.filetypes`: File types where indentation guides are hidden.
-- - `char_highlight_list`: Apply different colors to each indentation level.
--
-- Notes:
-- Customize the appearance of the guides by adjusting the `char` option or
-- applying colors using the highlight groups (`IndentBlanklineChar`, `IndentBlanklineIndent1`, etc.).
-- This setup enhances readability in nested code and can be tailored to your preferred style.
return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    indent = {
      char = '▏',
    },
    scope = {
      show_start = false,
      show_end = false,
      show_exact_scope = false,
    },
    exclude = {
      filetypes = {
        'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'Trouble',
      },
    },
  },
}
