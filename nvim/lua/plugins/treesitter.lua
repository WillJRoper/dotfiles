-- Plugin: nvim-treesitter
-- URL: https://github.com/nvim-treesitter/nvim-treesitter
--
-- Description:
-- `nvim-treesitter` provides Neovim with enhanced syntax highlighting, code navigation, and
-- editing capabilities using Treesitter, a modern incremental parsing library. This plugin
-- greatly improves code comprehension and editing by offering robust syntax-based highlighting,
-- smart indentation, and powerful text objects.
--
-- Features:
-- - **Syntax Highlighting**: Context-aware syntax highlighting that is more accurate and
--   performant than traditional regex-based highlighting.
-- - **Indentation**: Automatically adjusts indentation based on language syntax.
-- - **Incremental Selection**: Allows for expanding/shrinking selections by syntax nodes.
-- - **Extensible**: Additional modules like `nvim-treesitter-context` and `nvim-treesitter-textobjects`
--   enable features like current context display and powerful syntax-based text objects.
--
-- Configuration Options:
-- - `ensure_installed`: Defines the languages to be installed for Treesitter support. This configuration
--   includes a wide range of languages such as Lua, Python, JavaScript, TypeScript, C, and C++.
-- - `auto_install`: Ensures that Treesitter will automatically install any missing parsers.
-- - `highlight`: Enables syntax-based highlighting; you can also specify languages for `additional_vim_regex_highlighting`
--   if needed for better compatibility with certain language-specific indent rules.
-- - `indent`: Enables smart indentation based on language structure, with options to disable certain languages.
--
-- Notes:
-- - **C and C++ Support**: This configuration includes support for both C and C++.
-- - **Additional Modules**: Explore additional Treesitter modules for enhanced functionality, such as:
--   - `nvim-treesitter-context`: Shows the current code context at the top of the window.
--   - `nvim-treesitter-textobjects`: Enables syntax-based text objects for easy navigation and manipulation.
--   - `nvim-treesitter-refactor`: Provides additional code refactoring tools.
return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require 'nvim-treesitter.configs'

    -- configure treesitter
    treesitter.setup { -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        'lua',
        'python',
        'javascript',
        'typescript',
        'regex',
        'dockerfile',
        'toml',
        'json',
        'go',
        'gitignore',
        'yaml',
        'make',
        'cmake',
        'markdown',
        'markdown_inline',
        'bash',
        'css',
        'html',
        'c',
        'cpp', -- Added C and C++ support
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    }
  end,
}
