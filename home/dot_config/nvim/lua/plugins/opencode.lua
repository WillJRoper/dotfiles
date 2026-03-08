-- OpenCode helper integration.
--
-- Commands:
-- - :OpenCode     Open a terminal split running `opencode` (TUI)
-- - :OpenCodeAsk  Run `opencode run ...` and show output in a scratch buffer
--
-- Keymaps:
-- - <leader>oo    Open OpenCode TUI
-- - <leader>oa    Ask OpenCode (prompts for input)
-- - <leader>oA    Ask OpenCode with visual selection

return {
  -- No plugin dependency; this is a local integration layer.
  dir = vim.fn.stdpath('config'),
  name = 'opencode-local',
  lazy = false,
  config = function()
    local function open_opencode_tui()
      if vim.fn.executable('opencode') ~= 1 then
        vim.notify('`opencode` not found in PATH', vim.log.levels.ERROR)
        return
      end
      vim.cmd('botright split')
      vim.cmd('resize 15')
      vim.cmd('terminal opencode')
      vim.cmd('startinsert')
    end

    local function get_visual_selection()
      local start_pos = vim.fn.getpos("'<")
      local end_pos = vim.fn.getpos("'>")

      local start_row = start_pos[2] - 1
      local start_col = start_pos[3] - 1
      local end_row = end_pos[2] - 1
      local end_col = end_pos[3]

      if start_row < 0 or end_row < 0 then
        return nil
      end

      local lines = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})
      local text = table.concat(lines, '\n')
      if text == '' then
        return nil
      end
      return text
    end

    local function show_in_scratch(title, contents)
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
      vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })
      vim.api.nvim_set_option_value('swapfile', false, { buf = buf })
      vim.api.nvim_set_option_value('filetype', 'markdown', { buf = buf })

      local lines = vim.split(contents or '', '\n', { plain = true })
      if title and title ~= '' then
        table.insert(lines, 1, '# ' .. title)
        table.insert(lines, 2, '')
      end

      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
      vim.api.nvim_set_option_value('modifiable', false, { buf = buf })

      vim.cmd('botright vsplit')
      vim.api.nvim_win_set_buf(0, buf)
      vim.api.nvim_set_option_value('wrap', true, { win = 0 })
      vim.api.nvim_set_option_value('cursorline', false, { win = 0 })

      vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, silent = true, noremap = true })
    end

    local function opencode_ask(prompt, selection)
      if vim.fn.executable('opencode') ~= 1 then
        vim.notify('`opencode` not found in PATH', vim.log.levels.ERROR)
        return
      end
      if not prompt or prompt == '' then
        return
      end

      local bufname = vim.api.nvim_buf_get_name(0)
      local args = { 'opencode', 'run', '--dir', vim.fn.getcwd() }
      if bufname ~= '' and vim.fn.filereadable(bufname) == 1 then
        table.insert(args, '--file')
        table.insert(args, bufname)
      end

      local message = prompt
      if selection and selection ~= '' then
        local ft = vim.bo.filetype
        if not ft or ft == '' then
          ft = 'text'
        end
        message = message
          .. '\n\nSelected text:\n\n```'
          .. ft
          .. '\n'
          .. selection
          .. '\n```'
      end

      table.insert(args, message)

      vim.system(args, { text = true }, function(res)
        local out = (res.stdout or '')
        local err = (res.stderr or '')
        local combined = out
        if err ~= '' then
          combined = combined .. '\n\n---\n\n(stderr)\n\n' .. err
        end

        vim.schedule(function()
          show_in_scratch('OpenCode', combined)
        end)
      end)
    end

    vim.api.nvim_create_user_command('OpenCode', open_opencode_tui, {
      desc = 'Open OpenCode TUI in terminal split',
    })

    vim.api.nvim_create_user_command('OpenCodeAsk', function(cmd)
      local prompt = cmd.args
      if not prompt or prompt == '' then
        prompt = vim.fn.input('OpenCode ask: ')
      end
      opencode_ask(prompt)
    end, {
      nargs = '*',
      desc = 'Ask OpenCode and show output',
    })

    vim.keymap.set('n', '<leader>oo', open_opencode_tui, { desc = 'Open OpenCode' })
    vim.keymap.set('n', '<leader>oa', function()
      local prompt = vim.fn.input('OpenCode ask: ')
      opencode_ask(prompt)
    end, { desc = 'OpenCode ask' })
    vim.keymap.set('v', '<leader>oA', function()
      local selection = get_visual_selection()
      vim.cmd('normal! <Esc>')
      local prompt = vim.fn.input('OpenCode ask: ')
      opencode_ask(prompt, selection)
    end, { desc = 'OpenCode ask (selection)' })
  end,
}
