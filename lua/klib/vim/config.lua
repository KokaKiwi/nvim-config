local configs = {
  colorscheme = {
    set = function(name)
      vim.validate {
        name = { name, 'string' },
      }

      vim.cmd(string.format('colorscheme %s', name))
    end,
  },
}

local config_mt = {
  __index = function(_, key)
    local config = configs[key]
    if config == nil or config.get == nil then
      return nil
    end

    return config.get()
  end,
  __newindex = function(_, key, value)
    local config = configs[key]
    if config == nil or config.set == nil then
      return nil
    end

    return config.set(value)
  end,
}
vim.config = setmetatable({}, config_mt)
