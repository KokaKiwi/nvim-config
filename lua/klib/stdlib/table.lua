-- table.map
function table.map(t, fn, to_map)
  local result = {}

  for _, item in ipairs(t) do
    local left, right = fn(item)

    if to_map then
      if left ~= nil then
        result[left] = right
      end
    else
      local res = fn(item)
      table.insert(result, res)
    end

  end

  return result
end

---table.dmap
---@param t table
---@param fn function
---@return table
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

---table.filter
---@param t table
---@param fn function
---@return any[]
function table.filter(t, fn)
  local result = {}

  for _, item in ipairs(t) do
    if fn(item) then
      table.insert(result, item)
    end
  end

  return result
end

---table.dfilter
---@param t table
---@param fn function
---@return table
function table.dfilter(t, fn)
  local result = {}

  for key, value in pairs(t) do
    if fn(key, value) then
      result[key] = value
    end
  end

  return result
end

---table.filterkeys
---@param t table
---@param keys string[]
---@return table
function table.filterkeys(t, keys)
  return table.dfilter(t, function(key, _)
    return table.contains(keys, key)
  end)
end

---table.filtermap
---@param t table
---@param fn function
---@return table
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
  return table.fjoin(tables)
end

---table.fjoin
---@param tables any[]
---@return table
function table.fjoin(tables)
  local result = {}

  for _, t in ipairs(tables) do
    for _, item in ipairs(t) do
      table.insert(result, item)
    end
  end

  return result
end

function table.djoin(...)
  local tables = {...}
  local result = {}

  for _, t in ipairs(tables) do
    for key, value in pairs(t) do
      result[key] = value
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

---table.dextends
---@param t table
---@param items any[] | nil
---@return table | function
function table.dextends(t, items)
  if items == nil then
    return func.partial(table.extends, t)
  end

  for _, item in pairs(items) do
    table.insert(t, item)
  end

  return t
end

---@param t table
---@param deep boolean | nil
---@return table
function table.copy(t, deep)
  if deep == nil then
    deep = true
  end

  local seen = {}
  local function _copy(tbl)
    if seen[tbl] ~= nil then
      return seen[tbl]
    else
      local copy = {}
      seen[tbl] = copy

      for k, v in pairs(tbl) do
        if type(v) == 'table' then
          v = _copy(v)
        end
        copy[k] = v
      end

      return setmetatable(copy, getmetatable(tbl))
    end
  end

  return _copy(t)
end

---@param t table
---@return string[]
function table.keys(t)
  local keys = {}

  for key, _ in pairs(t) do
    table.insert(keys, key)
  end

  return keys
end
