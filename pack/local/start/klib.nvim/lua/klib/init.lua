function require_prefix(prefix, ...)
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

klib = {}

require_prefix('klib', 'vim', 'stdlib')
