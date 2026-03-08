-- Environment detection helpers.
--
-- Exports:
-- - hostname: string
-- - is_hpc: boolean (COSMA login nodes, or NVIM_HPC override)

local M = {}

local function get_hostname()
  if vim.uv and vim.uv.os_gethostname then
    return vim.uv.os_gethostname()
  end
  if vim.loop and vim.loop.os_gethostname then
    return vim.loop.os_gethostname()
  end
  return ''
end

local function parse_hpc_override()
  local v = vim.env.NVIM_HPC
  if not v or v == '' then
    return nil
  end
  v = tostring(v):lower()
  if v == '1' or v == 'true' or v == 'yes' then
    return true
  end
  if v == '0' or v == 'false' or v == 'no' then
    return false
  end
  return nil
end

local function is_cosma_login_node(hostname)
  local patterns = {
    '^login7%.cosma%.dur%.ac%.uk$',
    '^login7[abc]%.cosma%.dur%.ac%.uk$',
    '^login8%.cosma%.dur%.ac%.uk$',
    '^login8[ab]%.cosma%.dur%.ac%.uk$',
  }

  for _, pat in ipairs(patterns) do
    if hostname:match(pat) then
      return true
    end
  end

  return false
end

M.hostname = get_hostname()

do
  local override = parse_hpc_override()
  if override ~= nil then
    M.is_hpc = override
  else
    M.is_hpc = is_cosma_login_node(M.hostname)
  end
end

return M
