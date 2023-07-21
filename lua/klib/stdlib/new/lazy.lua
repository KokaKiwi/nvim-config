-- [nfnl] Compiled from fnl/klib/stdlib/new/lazy.fnl by https://github.com/Olical/nfnl, do not edit.
local Lazy
do
  local init
  local function _1_(self, initializer, cached)
    self.__initializer = initializer
    self.__initialized = false
    if (cached ~= nil) then
      self.__cached = cached
    else
      self.__cached = true
    end
    return nil
  end
  init = _1_
  local base
  local function _3_(self)
    if not self.__cached then
      return self.__initializer()
    elseif not self.__initialized then
      local value = self.__initializer()
      self.__initializer = nil
      self.__initialized = true
      self.__value = value
      return value
    else
      return self.__value
    end
  end
  base = {__getvalue = _3_}
  local metatable
  local function _5_(self, key)
    local value = self:__getvalue()
    return value[key]
  end
  local function _6_(self, ...)
    local value = self:__getvalue()
    return value(...)
  end
  metatable = {__index = _5_, __call = _6_}
  Lazy = _G.class.new(init, base, metatable)
end
_G.lazy = {Lazy = Lazy}
return _G.lazy
