_G.cond = {}

---@param value boolean
---@param then_value any
---@param else_value any
---@return any
function cond.if_else(value, then_value, else_value)
  if value then
    return then_value
  else
    return else_value
  end
end

---@param value boolean
---@param else_value any
---@return function(then_value:any):any
function cond.prefixed(value, else_value)
  return function(then_value)
    return cond.if_else(value, then_value, else_value)
  end
end

---@param name string
---@return boolean
function cond.has_package(name)
  local result, _ = pcall(require, name)

  return result
end
