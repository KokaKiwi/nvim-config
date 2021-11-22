_G.func = {}

---func.partial
---@param fn function
---@return function
function func.partial(fn, ...)
  local pargs = {...}

  return function(...)
    local args = {...}

    return fn(unpack(table.join(pargs, args)))
  end
end
