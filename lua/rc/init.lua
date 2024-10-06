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
vim.o.mouse = 'a'

vim.o.exrc = true
vim.o.secure = true
vim.o.hidden = true

vim.o.backup = false
vim.o.writebackup = false
vim.o.modeline = true

vim.o.updatetime = 300
vim.o.timeoutlen = 500

vim.o.exrc = true

require_prefix('rc.init') {
  'format', 'input', 'ui',
  'keymaps', 'filetypes',
}
pcall(require, 'rc.secret')
