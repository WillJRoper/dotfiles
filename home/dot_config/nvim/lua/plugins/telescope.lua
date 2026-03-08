-- Plugin: telescope.nvim
-- URL: https://github.com/nvim-telescope/telescope.nvim
--
-- Description:
-- `telescope.nvim` is a powerful fuzzy finder plugin for Neovim that allows users to quickly
-- locate files, text, and other content within their projects. It integrates with other Neovim
-- plugins, such as LSP and Git, and can be extended with various Telescope extensions.
--
-- Key Features:
-- - **File Finder**: Search for files, including hidden files, across the workspace.
-- - **Live Grep**: Quickly locate text within files using live grep search.
-- - **Integration with Projects**: The `telescope-project` extension enables easy project switching.
-- - **Customizable Key Mappings**: Predefined keybindings are provided for file search, live grep, help tags, and more.
-- - **UI Extensions**: `telescope-ui-select` provides enhanced UI options, and `telescope-fzf-native` enhances fuzzy matching.
--
-- Configuration Options:
-- - **Defaults**: Sets custom key mappings for next/previous selection and file selection, among others.
-- - **Pickers**:
--   - `find_files`: Customizes file searching with ignore patterns and hidden files.
--   - `live_grep`: Additional arguments allow live grep to search within hidden files.
-- - **Extensions**:
--   - `telescope-fzf-native`: Boosts fuzzy finding performance using FZF.
--   - `telescope-ui-select`: Enhances the UI with dropdowns for a smoother experience.
--   - `telescope-project`: Quickly switch between projects, configurable with `base_dirs` and search settings.
--
-- Usage Notes:
-- - Use `<leader>sp` to open the Projects picker.
-- - Use `<leader>sf` to search for files and `<leader>sg` to perform live grep.
-- - Additional key mappings are available for navigating Neovim’s help tags, buffers, and diagnostics.
--
-- This configuration is designed to streamline search and navigation within Neovim, making it easy to locate and
-- manage files, projects, and other resources in a consistent and highly customizable way.
return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

    -- Add the Telescope Projects extension
    {
      'nvim-telescope/telescope-project.nvim',
      config = function()
        require('telescope').load_extension 'project'
      end,
    },
    
    -- Add Telescope notify extension for notification history
    'rcarriga/nvim-notify',
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      defaults = {
        mappings = {
          i = {
            ['<C-k>'] = require('telescope.actions').move_selection_previous, -- move to prev result
            ['<C-j>'] = require('telescope.actions').move_selection_next, -- move to next result
            ['<C-l>'] = require('telescope.actions').select_default, -- open file
            ['<C-d>'] = require('telescope.actions').delete_buffer,
            ['<C-q>'] = require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist,
          },
          n = {
            ['<C-d>'] = require('telescope.actions').delete_buffer,
            ['<C-q>'] = require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist,
          },
        },
      },
      pickers = {
        find_files = {
          file_ignore_patterns = { 'node_modules', '^.git$', '.venv' },
          hidden = true,
        },
        live_grep = {
          file_ignore_patterns = { 'node_modules', '^.git$', '.venv' },
          additional_args = function(_)
            return {
              '--hidden',
              '-P',
            }
          end,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        project = { -- **Configure the Telescope Projects extension**
          base_dirs = {
            '~/Research', -- **Specify your projects directory here**
            '~/Miscellaneous',
            '~/Teaching',
            '~/dotfiles',
            -- { path = '~/work', max_depth = 2 },
          },
          hidden_files = true, -- default: false
          theme = 'dropdown', -- default: 'dropdown', can be 'ivy' or 'cursor'
          order_by = 'asc', -- default: 'asc', options: 'asc', 'desc'
          search_by = 'title', -- default: 'title', options: 'title', 'desc', 'path'
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'project')
    pcall(require('telescope').load_extension, 'notify')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set(
      'n',
      '<leader>sh',
      builtin.help_tags,
      { desc = '[S]earch [H]elp' }
    )
    vim.keymap.set(
      'n',
      '<leader>sk',
      builtin.keymaps,
      { desc = '[S]earch [K]eymaps' }
    )
    vim.keymap.set(
      'n',
      '<leader>sf',
      builtin.find_files,
      { desc = '[S]earch [F]iles' }
    )
    vim.keymap.set(
      'n',
      '<leader>ss',
      builtin.builtin,
      { desc = '[S]earch [S]elect Telescope' }
    )
    vim.keymap.set(
      'n',
      '<leader>sw',
      builtin.grep_string,
      { desc = '[S]earch current [W]ord' }
    )
    vim.keymap.set(
      'n',
      '<leader>sg',
      builtin.live_grep,
      { desc = '[S]earch by [G]rep' }
    )
    vim.keymap.set(
      'n',
      '<leader>sd',
      builtin.diagnostics,
      { desc = '[S]earch [D]iagnostics' }
    )
    vim.keymap.set(
      'n',
      '<leader>sr',
      builtin.resume,
      { desc = '[S]earch [R]esume' }
    )
    vim.keymap.set(
      'n',
      '<leader>s.',
      builtin.oldfiles,
      { desc = '[S]earch Recent Files ("." for repeat)' }
    )
    vim.keymap.set(
      'n',
      '<leader><leader>',
      builtin.buffers,
      { desc = '[ ] Find existing buffers' }
    )
    vim.keymap.set(
      'n',
      '<leader>sp',
      require('telescope').extensions.project.project,
      { desc = '[S]earch [P]rojects' }
    )

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = true,
        }
      )
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Function to search for the string under the cursor
    vim.keymap.set('n', '<leader>sG', function()
      builtin.live_grep {
        default_text = vim.fn.expand '<cword>', -- Search for the word under the cursor
        prompt_title = 'Live Grep for Word Under Cursor',
      }
    end, { desc = '[S]earch [G]rep for Word Under Cursor' })
  end,
}
