-- Load Lua helpers
require('klib')

-- Load plugins
require('rc.plugins')

local luarocks = require('packer.luarocks')
luarocks.install_commands()
vim.after.register(function()
  luarocks.setup_paths()
end)

-- Basic init
vim.opt.shell = '/bin/bash'

vim.opt.mouse = 'a'

vim.opt.exrc = true
vim.opt.secure = true
vim.opt.hidden = true

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.modeline = true

vim.opt.updatetime = 300
vim.opt.timeoutlen = 500

vim.g.python3_host_prog = '/usr/bin/python'

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

require_prefix('rc.init', 'format', 'input', 'ui', 'plugins')

pcall(require, 'rc.secret')
