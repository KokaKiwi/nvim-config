---@diagnostic disable: redefined-local
local util = require('rc.plugins.util')

local lazy = util.require_lazy()
lazy.setup('rc.plugins.spec', {
    checker = {
      enabled = true,
      concurrency = 8,
      notify = false,
    },
    dev = {
      path = vim.fn.stdpath('config') .. '/local',
    },
    install = {
      colorscheme = { 'catppuccin', 'uwu' },
    },
})
