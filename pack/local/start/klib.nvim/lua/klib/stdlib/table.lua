-- table.map
function table.map(t, fn)
  local result = {}

  for _, item in ipairs(t) do
    table.insert(result, fn(item))
  end

  return result
end

-- table.reducemap
function table.reducemap(t, fn)
  local result = {}

  for _, item in ipairs(t) do
    local res, value = fn(item)
    if res then
      table.insert(result, value)
    end
  end

  return result
end

-- table.any
function table.any(t, fn)
  for _, item in ipairs(t) do
    if fn(item) then
      return true
    end
  end

  return false
end

-- table.contains
function table.contains(t, value)
  return table.any(t, function(item) return item == value end)
end

-- table.join
function table.join(...)
  local tables = {...}
  local result = {}

  for _, t in ipairs(tables) do
    for _, item in ipairs(t) do
      table.insert(result, item)
    end
  end

  return result
end

-- table.append
function table.append(t, ...)
  local items = {...}

  for _, item in ipairs(items) do
    table.insert(t, item)
  end

  return t
end
