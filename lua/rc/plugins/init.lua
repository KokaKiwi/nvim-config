---@diagnostic disable: redefined-local
local util = require('rc.plugins.util')

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
