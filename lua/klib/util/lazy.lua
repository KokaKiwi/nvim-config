local lazy = {}

function lazy.dict(builder, cache)
  if cache == nil then
    cache = true
  end

  local mt = {}

  local function get_value()
    if cache then
      if mt._value == nil then
        mt._value = builder()
      end

      return mt._value
    else
      return builder()
    end
  end

  mt.__index = function(_, key)
    return get_value()[key]
  end
  mt.__newindex = function(_, key, val)
    get_value()[key] = val
  end

  mt.__metatable = false

  return setmetatable({}, mt)
end

function lazy.require(module)
  return lazy.dict(function()
    return require(module)
  end, true)
end

return lazy
