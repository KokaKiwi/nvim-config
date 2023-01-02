local util = require('rc.plugins.util')

local local_plugins_path = vim.fn.stdpath('config') .. '/local'

return util.module('local', function(use)
  for _, entry in ipairs(fs.readdir(local_plugins_path)) do
    use {
      ['local'] = entry.name,
    }
  end
end)
