local xdg = {}

local function getenv(name, default)
  local value = os.getenv(name) or default

  return vim.fn.expand(value)
end

xdg.XDG_DATA_HOME = getenv('XDG_DATA_HOME', '~/.local/share')
xdg.XDG_CONFIG_HOME = getenv('XDG_CONFIG_HOME', '~/.config')

return xdg
