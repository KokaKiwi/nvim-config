_G.klib = {}

function klib.prefixed(t, prefix, sep)
  if sep == nil then
    sep = '_'
  end

  return function(values)
    for key, value in pairs(values) do
      t[string.format('%s%s%s', prefix, sep, key)] = value
    end
  end
end
_G.prefixed = klib.prefixed

function klib.require_prefix(prefix, ...)
  local modules = {...}

  if #modules == 0 then
    return function(...)
      require_prefix(prefix, ...)
    end
  elseif #modules == 1 and type(modules[1]) == 'table' then
    modules = modules[1]
  end

  for _, mod in pairs(modules) do
    require(string.format('%s.%s', prefix, mod))
  end
end
_G.require_prefix = klib.require_prefix

require_prefix('klib', 'vim', 'stdlib')
