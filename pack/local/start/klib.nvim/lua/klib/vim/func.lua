local MT = {}

local function_template = [[function! %s(...)
  call luaeval('pcall(vim.func.%s, unpack(_A))', a:000)
endfunction]]

function MT:__newindex(name, value)
  local already_exists = rawget(self, name) ~= nil

  rawset(self, name, value)

  if not already_exists then
    local func = string.format(function_template, name, name)
    vim.api.nvim_exec(func, false)
  end
end

vim.func = setmetatable({}, MT)
