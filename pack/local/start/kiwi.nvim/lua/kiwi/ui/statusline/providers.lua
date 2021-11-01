local lsp_status = require('lsp-status')

local providers = {}

---@return function
function providers.fixed_string(...)
  local strings = {...}
  return function() return table.concat(strings) end
end

---@param width number
---@return function
function providers.space(width)
  width = width or 1
  return providers.fixed_string(string.rep(' ', width))
end

---@return function(): string
function providers.lsp_status()
  return function()
    return lsp_status.status():gsub('%%%%', '%%')
  end
end

return providers
