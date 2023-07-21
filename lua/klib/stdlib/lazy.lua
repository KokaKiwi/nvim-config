_G.lazy = {}

lazy.Lazy = class.new(function(self, initializer, cached)
  if cached == nil then
    cached = true
  end

  self.__initializer = initializer
  self.__initialized = false
  self.__cached = cached
end, {
  __getvalue = function(self)
    local value

    if not self.__cached then
      value = self.__initializer()
    elseif not self.__initialized then
      value = self.__initializer()

      self.__initializer = nil
      self.__initialized = true
      self.__value = value
    else
      value = self.__value
    end

    return value
  end,
}, {
  __index = function(self, key)
    local value = self:__getvalue()
    return value[key]
  end,

  __call = function(self, ...)
    local value = self:__getvalue()
    return value(...)
  end,
})

lazy.require = function(name)
  return lazy.Lazy(function()
    return require(name)
  end)
end
