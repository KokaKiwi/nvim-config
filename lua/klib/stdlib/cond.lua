-- [nfnl] Compiled from fnl/klib/stdlib/cond.fnl by https://github.com/Olical/nfnl, do not edit.
local function if_else(value, _then, _else)
  if value then
    return _then
  else
    return _else
  end
end
local function prefixed(value, _else)
  local function _2_(_then)
    return if_else(value, _then, _else)
  end
  return _2_
end
local function has_package(name)
  local _let_3_ = pcall(require, name)
  local result = _let_3_[1]
  local _ = _let_3_[2]
  return result
end
_G.cond = {if_else = if_else, prefixed = prefixed, has_package = has_package}
return nil
