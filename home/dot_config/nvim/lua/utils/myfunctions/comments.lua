local M = {}

function M.align_yaml_comments()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local max = 0

  for _, line in ipairs(lines) do
    local s = line:match '^(.-)%s*#'
    if s then
      local len = vim.fn.strdisplaywidth(s)
      if len > max then
        max = len
      end
    end
  end

  for i, line in ipairs(lines) do
    local before, comment = line:match '^(.-)%s*#(.*)'
    if before and comment then
      local pad = string.rep(' ', max - vim.fn.strdisplaywidth(before))
      lines[i] = before .. pad .. ' # ' .. comment
    end
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

return M
