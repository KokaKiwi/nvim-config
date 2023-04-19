local MT = {}

local function_template = [[function! %s(...)
  return v:lua.vim.func.%s(a:000)
endfunction]]

function MT:__newindex(name, value)
  local already_exists = rawget(self, name) ~= nil

  local wrapper = function(args)
    return value(unpack(args))
  end
  rawset(self, name, wrapper)

  if not already_exists then
    local func = string.format(function_template, name, name)
    vim.api.nvim_exec2(func)
  end
end

vim.func = setmetatable({}, MT)
