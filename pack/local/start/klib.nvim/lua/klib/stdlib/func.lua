_G.func = {}

-- func.partial
function func.partial(fn, ...)
  local pargs = {...}

  return function(...)
    local args = {...}

    return fn(unpack(table.join(pargs, args)))
  end
end
