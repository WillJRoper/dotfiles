-- Plugin: CopilotChat.nvim
-- URL: https://github.com/CopilotC-Nvim/CopilotChat.nvim
--
-- Description:
-- Interactive chat interface for GitHub Copilot that provides context-aware AI assistance.
-- Works seamlessly with your existing copilot.lua setup to offer conversational AI capabilities
-- for code explanation, refactoring suggestions, debugging help, and more.
--
-- Key Features:
-- - Context-aware chat using current buffer, selections, and workspace
-- - Visual selection integration for targeted questions
-- - Inline diff suggestions for refactoring
-- - Multiple chat models and prompt templates
-- - Integration with existing Copilot authentication

return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'main',
  enabled = function()
    return not require('core.env').is_hpc
  end,
  dependencies = {
    { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
    { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  },
  build = 'make tiktoken', -- Only on MacOS or Linux
  opts = {
    debug = false, -- Enable debugging
    
    -- Chat window configuration
    window = {
      layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
      width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
      height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
      -- Options below only apply to floating windows
      relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
      border = 'rounded', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
      row = nil, -- row position of the window, default is centered
      col = nil, -- column position of the window, default is centered
      title = 'Copilot Chat', -- title of chat window
      footer = nil, -- footer of chat window
      zindex = 1, -- determines if window is on top or below other floating windows
    },

    -- Chat behavior
    question_header = '## User ', -- Header to use for user questions
    answer_header = '## Copilot ', -- Header to use for AI answers
    error_header = '## Error ', -- Header to use for errors
    separator = '───', -- Separator to use in chat

    -- Default prompts
    prompts = {
      Explain = {
        prompt = '/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.',
      },
      Review = {
        prompt = '/COPILOT_REVIEW Review the selected code.',
        callback = function(response, source)
          -- see config.lua for implementation
        end,
      },
      Fix = {
        prompt = '/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.',
      },
      Optimize = {
        prompt = '/COPILOT_GENERATE Optimize the selected code to improve performance and readablilty.',
      },
      Docs = {
        prompt = '/COPILOT_GENERATE Please add documentation comment for the selection.',
      },
      Tests = {
        prompt = '/COPILOT_GENERATE Please generate tests for my code.',
      },
      FixDiagnostic = {
        prompt = 'Please assist with the following diagnostic issue in file:',
        selection = function(source)
          return require('CopilotChat.select').diagnostics(source)
        end,
      },
      Commit = {
        prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
        selection = function(source)
          return require('CopilotChat.select').gitdiff(source)
        end,
      },
      CommitStaged = {
        prompt = 'Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.',
        selection = function(source)
          return require('CopilotChat.select').gitdiff(source, true)
        end,
      },
    },

    auto_follow_cursor = true, -- Don't follow the cursor after getting response
    auto_insert_mode = false, -- Automatically enter insert mode when opening window and if auto follow cursor is enabled on new prompt
    clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
    highlight_selection = true, -- Highlight selection in the source buffer when in the chat window

    context = 'buffers', -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
    history_path = vim.fn.stdpath('data') .. '/copilotchat_history', -- Default path to stored history
    callback = nil, -- Callback to use when ask response is received

    -- default selection (visual or line)
    selection = function(source)
      return require('CopilotChat.select').visual(source) or require('CopilotChat.select').line(source)
    end,

    -- default mappings
    mappings = {
      complete = {
        detail = 'Use @<Tab> or /<Tab> for options.',
        insert = '<Tab>',
      },
      close = {
        normal = 'q',
        insert = '<C-c>'
      },
      reset = {
        normal = '<C-x>',
        insert = '<C-x>'
      },
      submit_prompt = {
        normal = '<CR>',
        insert = '<C-s>'
      },
      accept_diff = {
        normal = '<C-y>',
        insert = '<C-y>'
      },
      yank_diff = {
        normal = 'gy',
        register = '"',
      },
      show_diff = {
        normal = 'gd'
      },
      show_info = {
        normal = 'gp'
      },
      show_context = {
        normal = 'gs'
      },
    },
  },
  config = function(_, opts)
    local chat = require('CopilotChat')
    local select = require('CopilotChat.select')
    
    -- Use unnamed register for the selected text
    opts.selection = select.unnamed

    chat.setup(opts)

    -- AI keymaps using <leader>a prefix
    vim.keymap.set('n', '<leader>aq', function()
      local input = vim.fn.input('Quick Chat: ')
      if input ~= '' then
        chat.ask(input, { selection = select.buffer })
      end
    end, { desc = '[A]I [Q]uick chat' })

    vim.keymap.set('n', '<leader>ah', function()
      local actions = require('CopilotChat.actions')
      require('CopilotChat.integrations.telescope').pick(actions.help_actions())
    end, { desc = '[A]I [H]elp actions' })

    vim.keymap.set('n', '<leader>ap', function()
      local actions = require('CopilotChat.actions')
      require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
    end, { desc = '[A]I [P]rompt actions' })

    vim.keymap.set({'n', 'v'}, '<leader>aP', function()
      local actions = require('CopilotChat.actions')
      require('CopilotChat.integrations.telescope').pick(actions.prompt_actions({
        selection = select.visual,
      }))
    end, { desc = '[A]I [P]rompt actions (visual)' })

    -- Chat with Copilot in visual mode
    vim.keymap.set('v', '<leader>av', function()
      chat.open()
    end, { desc = '[A]I [V]isual chat' })

    -- Inline chat with Copilot
    vim.keymap.set('v', '<leader>ai', function()
      chat.ask(
        vim.fn.input('Quick Chat: '),
        { selection = select.visual }
      )
    end, { desc = '[A]I [I]nline chat' })

    -- Generate commit message based on the git diff
    vim.keymap.set('n', '<leader>am', function()
      chat.ask('Write commit message for the change with commitizen convention.', {
        selection = select.gitdiff,
      })
    end, { desc = '[A]I commit [M]essage' })

    -- Quick fixes using Copilot
    vim.keymap.set('n', '<leader>af', function()
      chat.ask('There is a problem in this code. Rewrite the code to show it with the bug fixed.', {
        selection = select.buffer,
      })
    end, { desc = '[A]I [F]ix code' })

    -- Explain current buffer
    vim.keymap.set('n', '<leader>ae', function()
      chat.ask('Explain how this code works.', {
        selection = select.buffer,
      })
    end, { desc = '[A]I [E]xplain code' })

    -- Review current buffer
    vim.keymap.set('n', '<leader>ar', function()
      chat.ask('Review this code and suggest improvements.', {
        selection = select.buffer,
      })
    end, { desc = '[A]I [R]eview code' })

    -- Generate tests
    vim.keymap.set({'n', 'v'}, '<leader>at', function()
      chat.ask('Generate tests for this code.', {
        selection = select.visual,
      })
    end, { desc = '[A]I generate [T]ests' })

    -- Optimize code
    vim.keymap.set({'n', 'v'}, '<leader>ao', function()
      chat.ask('Optimize this code for better performance and readability.', {
        selection = select.visual,
      })
    end, { desc = '[A]I [O]ptimize code' })

    -- Generate documentation
    vim.keymap.set({'n', 'v'}, '<leader>ad', function()
      chat.ask('Add documentation comments for this code.', {
        selection = select.visual,
      })
    end, { desc = '[A]I [D]ocumentation' })

    -- Custom diagnostic help
    vim.keymap.set('n', '<leader>aD', function()
      chat.ask('Explain this diagnostic and how to fix it.', {
        selection = select.diagnostics,
      })
    end, { desc = '[A]I [D]iagnostic help' })

    -- Toggle Copilot Chat
    vim.keymap.set('n', '<leader>aC', function()
      chat.toggle()
    end, { desc = '[A]I [C]hat toggle' })

    -- Reset chat
    vim.keymap.set('n', '<leader>ax', function()
      chat.reset()
    end, { desc = '[A]I reset chat' })
  end,
  event = 'VeryLazy',
}
