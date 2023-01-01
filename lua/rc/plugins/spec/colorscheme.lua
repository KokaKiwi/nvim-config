local util = require('rc.plugins.util')

return util.module('colorscheme', function(use)
  use { 'catppuccin/nvim',
    name = 'catppuccin',
    build = ':CatppuccinCompile',
    config = util.setup.mod_call('kiwi.ui.colorscheme'),
  }

  use { 'kartikp10/noctis.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
  }
end)
