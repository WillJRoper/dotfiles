-- Plugin: Neogit
-- URL: https://github.com/NeogitOrg/neogit
--
-- Description:
-- `Neogit` is a powerful, Git client for Neovim inspired by Magit from Emacs. It offers
-- a highly interactive, buffer-based experience for managing Git repositories, allowing
-- you to perform most Git operations directly within Neovim.
--
-- Key Features:
-- - **Interactive Git Status Buffer**: See the current state of your repository and stage,
--   unstage, or commit changes all from within Neovim.
-- - **Floating Windows**: Configured to use floating windows for the status, commit,
--   and other popups, providing a seamless workflow without obstructing your workspace.
-- - **Diffview Integration**: Integrates with `diffview.nvim` for enhanced diff viewing,
--   offering more detailed views of file changes and commits.
-- - **Telescope Integration**: Works with Telescope for fuzzy finding of commits and branches,
--   making it easier to navigate your repository’s history.
--
-- Configuration Options:
-- - **Floating Windows**: All main Neogit windows (status, commit popup, and other popups)
--   are set to open in floating windows to reduce disruption to your workspace.
-- - **Diffview**: Enables integration with Diffview, allowing you to view diffs in a more detailed way.
-- - **Commit Confirmation**: You can disable the commit confirmation prompt if you prefer a faster commit experience.
--
-- Usage Notes:
-- - Use `:Neogit` to open the main status window and start interacting with your Git repository.
-- - Key mappings are similar to Magit, allowing you to stage, unstage, commit, and perform other Git operations.
-- - For enhanced diff views, leverage the Diffview integration, enabling easy inspection of changes.
return {
  'NeogitOrg/neogit',
  branch = 'master',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required
    'sindrets/diffview.nvim', -- Optional - Diffview integration
    'nvim-telescope/telescope.nvim', -- Optional
  },
  config = function()
    local neogit = require 'neogit'

    -- Function to prompt saving unsaved buffers individually
    local function prompt_save_buffers()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        -- Check if the buffer is loaded, valid, and modified
        if
          vim.api.nvim_buf_is_loaded(buf)
          and vim.api.nvim_buf_is_valid(buf)
          and vim.bo[buf].modified
        then
          local bufname = vim.api.nvim_buf_get_name(buf)
          local choice = vim.fn.confirm(
            'Save changes to ' .. bufname .. '?',
            '&Yes\n&No\n&Cancel',
            1
          )
          if choice == 1 then
            vim.api.nvim_buf_call(buf, function()
              vim.cmd 'silent! w'
            end)
          elseif choice == 3 then
            -- If 'Cancel' is chosen, stop the process
            return false
          end
        end
      end
      return true
    end

    -- Function to check if the current file is in a Git repository
    local function is_in_git_repo()
      local git_root = vim.fn.systemlist 'git rev-parse --is-inside-work-tree'
      return git_root[1] == 'true'
    end

    -- Function to get conflicted files using git status
    local function get_conflicted_files()
      local result = {}
      -- Run `git status --porcelain` to get a list of changed files
      local status_output = vim.fn.systemlist 'git status --porcelain'
      for _, line in ipairs(status_output) do
        -- Check if the line indicates a conflict (marked with "UU")
        if line:sub(1, 2) == 'UU' then
          -- The file path starts after the status indicator
          table.insert(result, line:sub(4))
        end
      end
      return result
    end

    -- Function to stage files with resolved conflicts
    local function stage_resolved_conflicts()
      local conflicted_files = get_conflicted_files()
      for _, file in ipairs(conflicted_files) do
        -- Check if the file still has merge conflicts
        local resolved = vim.fn.systemlist('git diff --check ' .. file)
        if #resolved == 0 then
          -- No merge conflict markers found, so stage the file
          vim.cmd('silent !git add ' .. file)
          print('Staged resolved conflict file:', file)
        end
      end
    end

    -- Auto-stage resolved conflict files on buffer save if inside a git repository
    -- DISABLED: This was causing file write conflicts
    -- vim.api.nvim_create_autocmd('BufWritePost', {
    --   callback = function()
    --     if is_in_git_repo() then
    --       stage_resolved_conflicts()
    --     end
    --   end,
    -- })
    -- Customize Neogit setup
    neogit.setup {
      kind = 'floating', -- Open Neogit in a floating window
      auto_refresh = true, -- Automatically refresh the status buffer
      open_on_diff = false, -- Automatically open diff view on staging

      integrations = {
        diffview = true, -- Enable integration with Diffview
      },

      -- Hides the hints at the top of the status buffer
      disable_hint = true,

      -- When enabled, will watch the `.git/` directory for changes and
      -- refresh the status buffer in response to filesystem events.
      filewatcher = {
        interval = 1000,
        enabled = true,
      },

      commit_popup = {
        kind = 'floating',
        auto_insert = true, -- Auto-insert last commit message
      },

      popup = {
        kind = 'floating',
      },

      pull_popup = {
        kind = 'split',
        auto_push_on_commit = false,
      },

      push_popup = {
        kind = 'split',
      },

      signs = {
        section = { '', '' },
        item = { '', '' },
        hunk = { '', '' },
      },

      sections = {
        untracked = {
          folded = true, -- Expand untracked files by default
        },
        recent = {
          folded = true, -- Fold recent commits by default
        },
      },

      mappings = {
        status = {
          ['<tab>'] = 'Toggle', -- Use <tab> to toggle sections
          ['q'] = function()
            -- Run checktime on all buffers to refresh them
            vim.cmd 'silent! checktime'
            -- Close the current Neogit buffer
            vim.cmd 'q'
          end,
        },
      },
    }

    -- Add a custom command to check for unsaved buffers and open Neogit
    vim.api.nvim_create_user_command('Neogit', function()
      if prompt_save_buffers() then
        neogit.open() -- Open Neogit only if user doesn't cancel
      end
    end, {})
  end,
}
