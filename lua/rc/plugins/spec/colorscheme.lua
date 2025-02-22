local util = require('rc.plugins.util')

return util.module('colorscheme', function(use)
  use { 'catppuccin/nvim',
    name = 'catppuccin',
    build = ':CatppuccinCompile',
    lazy = false,
    config = util.setup.mod_call('kiwi.ui.colorscheme'),
    priority = 1000,
  }

  use { 'kartikp10/noctis.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    lazy = true,
  }
end)
