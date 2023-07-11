-- [nfnl] Compiled from fnl/klib/stdlib/new/table.fnl by https://github.com/Olical/nfnl, do not edit.
table.map = function(t, f, _3fto_map)
  local result = {}
  for _, item in ipairs(t) do
    if _3fto_map then
      local _let_1_ = f(item)
      local left = _let_1_[1]
      local right = _let_1_[2]
      if (left ~= nil) then
        result[left] = right
      else
      end
    else
      local res = f(item)
      table.insert(result, res)
    end
  end
  return result
end
table.dmap = function(t, f, _3fto_list)
  local result = {}
  for key, value in pairs(t) do
    local _let_4_ = f(key, value)
    local a = _let_4_[1]
    local b = _let_4_[2]
    if (b ~= nil) then
      result[a] = b
    else
      if _3fto_list then
        table.insert(result, a)
      else
        result[key] = a
      end
    end
  end
  return result
end
table.any = function(t, f)
  local result = false
  for _, item in ipairs(t) do
    if result then break end
    if f(item) then
      result = true
    else
    end
  end
  return result
end
table.contains = function(t, value)
  local function _8_(item)
    return (item == value)
  end
  return table.any(t, _8_)
end
table.filter = function(t, f)
  local result = {}
  for _, item in ipairs(t) do
    if f(item) then
      table.insert(result, item)
    else
    end
  end
  return result
end
table.dfilter = function(t, f)
  local result = {}
  for key, value in pairs(t) do
    if f(key, value) then
      result[key] = value
    else
    end
  end
  return result
end
table.filterkeys = function(t, keys)
  local function _11_(key, _)
    return table.contains(keys, key)
  end
  return table.dfilter(t, _11_)
end
table.filtermap = function(t, f)
  local result = {}
  for _, item in ipairs(t) do
    local _let_12_ = f(item)
    local res = _let_12_[1]
    local value = _let_12_[2]
    if res then
      table.insert(result, value)
    else
    end
  end
  return result
end
table.fjoin = function(tables)
  local result = {}
  for _, t in ipairs(tables) do
    for _0, item in ipairs(t) do
      table.insert(result, item)
    end
  end
  return result
end
table.fdjoin = function(tables)
  local result = {}
  for _, t in ipairs(tables) do
    for key, value in pairs(t) do
      result[key] = value
    end
  end
  return result
end
table.djoin = function(...)
  return table.fdjoin({...})
end
table.join = function(...)
  return table.fjoin({...})
end
table.extends = function(t, items)
  if (items == nil) then
    local function _14_(...)
      return table.extends(t, ...)
    end
    return _14_
  else
    for _, item in ipairs(items) do
      table.insert(t, item)
    end
    return t
  end
end
table.dextends = function(t, items)
  if (items == nil) then
    local function _16_(...)
      return table.dextends(t, ...)
    end
    return _16_
  else
    for _, item in pairs(items) do
      table.insert(t, item)
    end
    return t
  end
end
table.append = function(t, ...)
  return table.extends(t, {...})
end
table.keys = function(t)
  local keys = {}
  for key, _ in pairs(t) do
    table.insert(keys, key)
  end
  return keys
end
table.resolve = function(t, path)
  local cur = t
  for _, key in ipairs(path) do
    cur = cur[key]
  end
  return cur
end
table.copy = function(t, deep_3f)
  local deep_3f0
  if (deep_3f ~= nil) then
    deep_3f0 = deep_3f
  else
    deep_3f0 = true
  end
  local seen = {}
  local function do_copy(t0)
    if (seen[t0] ~= nil) then
      return seen[t0]
    else
      local copy = {}
      seen[t0] = copy
      for k, v in pairs(t0) do
        local _19_
        if (deep_3f0 and (type(v) == "table")) then
          _19_ = do_copy(v)
        else
          _19_ = v
        end
        copy[k] = _19_
      end
      return setmetatable(copy, getmetatable(t0))
    end
  end
  return do_copy(t)
end
return table.copy
