-- table.map
function table.map(t, fn)
  local result = {}

  for _, item in ipairs(t) do
    table.insert(result, fn(item))
  end

  return result
end

---table.dmap
---@param t table
---@param fn function
function table.dmap(t, fn, to_list)
  if to_list == nil then
    to_list = false
  end

  local result = {}

  for key, value in pairs(t) do
    local a, b = fn(key, value)

    if b ~= nil then
      result[a] = b
    else
      if to_list then
        table.insert(result, a)
      else
        result[key] = a
      end
    end
  end

  return result
end

---table.reducemap
function table.filtermap(t, fn)
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

---table.join
---@return table
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

---table.append
---@param t table
---@return table
function table.append(t, ...)
  local items = {...}
  return table.extends(t, items)
end

---table.extends
---@param t table
---@param items any[] | nil
---@return table | function
function table.extends(t, items)
  if items == nil then
    return func.partial(table.extends, t)
  end

  for _, item in ipairs(items) do
    table.insert(t, item)
  end

  return t
end
