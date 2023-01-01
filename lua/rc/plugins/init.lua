---@diagnostic disable: redefined-local
local util = require('rc.plugins.util')

local lazy = util.require_lazy()
lazy.setup('rc.plugins.spec', {
    checker = {
      enabled = true,
    },
    install = {
      colorscheme = { 'catppuccin', 'uwu' },
    },
})
