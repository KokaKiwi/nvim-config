-- Load Lua helpers
require('klib')

-- Don't do full boostrap if NO_BOOTSTRAP env var is 1
if os.getenv('NO_BOOTSTRAP') == '1' then
  return
end

-- Load plugins
require('rc.plugins')

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

require_prefix('rc.init') {
  'format', 'input', 'ui',
  'keymaps',
}
pcall(require, 'rc.secret')
