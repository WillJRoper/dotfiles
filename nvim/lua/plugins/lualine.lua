-- Plugin: lualine.nvim
-- URL: https://github.com/nvim-lualine/lualine.nvim
--
-- Description:
-- `lualine.nvim` is a highly customizable and performant statusline plugin for Neovim
-- written in Lua. It allows you to configure a dynamic statusline with various sections,
-- components, and custom options, enhancing your editing experience by displaying
-- contextually relevant information about the current buffer, mode, diagnostics, and more.
--
-- Features:
-- - Supports icons and custom glyphs, integrating seamlessly with font icons.
-- - Displays current mode, filename, git branch, diagnostics, encoding, file type, and more.
-- - Configurable separators, with multiple themes and custom color options.
-- - Supports conditional display for components based on window width or file type.
-- - Integrates with plugins like `fugitive` to show additional information.
--
-- Configuration Options:
-- - `theme`: The color theme used for the statusline (e.g., 'nord').
-- - `section_separators` and `component_separators`: Customize separators between sections and components.
-- - `sections`: Configure individual sections (e.g., `lualine_a`, `lualine_b`) with components like `mode`, `branch`, and `filename`.
-- - `diagnostics` and `diff`: Display LSP diagnostics and version control diffs with custom symbols.
-- - `inactive_sections`: Define how the statusline looks when windows are inactive.
--
-- Notes:
-- - This configuration includes a custom mode symbol (``) and diagnostics with error and warning icons.
-- - Only displays certain components (e.g., encoding, file type) when the window width exceeds 100.
return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local mode = {
      'mode',
      fmt = function(str)
        return ' ' .. str
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
      end,
    }

    local filename = {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      colored = false,
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      'diff',
      colored = false,
      symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
      cond = hide_in_width,
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'nord', -- Set theme based on environment variable
        -- Some useful glyphs:
        -- https://www.nerdfonts.com/cheat-sheet
        --        
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'neo-tree' },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { 'branch' },
        lualine_c = { filename },
        lualine_x = { diagnostics, diff, { 'encoding', cond = hide_in_width }, { 'filetype', cond = hide_in_width } },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    }
  end,
}
