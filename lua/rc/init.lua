-- Teal support
local has_tl, tl = pcall(require, 'tl')
if has_tl then
  tl.loader()
end

-- Load Lua helpers
require('klib')

-- Load plugins
vim.g.mapleader = ','
vim.g.maplocalleader = ';'
require('rc.plugins').setup()

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

vim.o.exrc = true

vim.g.python3_host_prog = '/usr/bin/python'

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0

require_prefix('rc.init') {
  'format', 'input', 'ui',
  'keymaps',
}
pcall(require, 'rc.secret')
