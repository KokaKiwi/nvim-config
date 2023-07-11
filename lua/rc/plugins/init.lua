local M = {}

function M.setup()
  local util = require('rc.plugins.util')

  local home = os.getenv('HOME')
  package.path = string.format(
    '%s;%s/.luarocks/share/lua/5.1/?/init.lua;%s/.luarocks/share/lua/5.1/?.lua',
    package.path,
    home, home
  )

  local lazy = util.require_lazy()
  lazy.setup('rc.plugins.spec', {
    checker = {
      notify = false,
    },
    dev = {
      path = vim.fn.stdpath('config') .. '/local',
    },
    diff = {
      cmd = 'diffview.nvim',
    },
    install = {
      colorscheme = { 'catppuccin', 'uwu' },
    },
    ui = {
      icons = {
        cmd = '⌘',
        config = '🛠',
        event = '📅',
        ft = '📂',
        init = '⚙',
        keys = '🗝',
        plugin = '📦',
        runtime = '💻',
        source = '📄',
        start = '🚀',
        task = '📌',
        lazy = '💤 ',
      },
    },
  })
end

return M
