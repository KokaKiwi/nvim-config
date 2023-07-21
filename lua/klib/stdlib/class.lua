require('klib.stdlib.table')

_G.class = {}

function class.new(init, base, mt)
  if base == nil then
    base = {}
  end

  return function(...)
    local obj = setmetatable(table.copy(base, false), mt)
    init(obj, ...)
    return obj
  end
end
