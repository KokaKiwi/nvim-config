--- vim.fn.has helper
---@param feature string
---@return boolean true if {feature} is supported, false otherwise
function vim.has(feature)
  return vim.fn.has(feature) == 1
end
