local util = require('rc.plugins.util')

return util.module('ui', function(use)
  use { 'RRethy/vim-illuminate',
    config = util.setup.rc('illuminate'),
    lazy = true,
  }
  use { 'norcalli/nvim-colorizer.lua',
    config = util.setup.rc('colorizer'),
  }
  use { 'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPre' },
    config = util.setup.rc('blankline', 'ui'),
  }
  use { 'folke/todo-comments.nvim',
    dependencies = { 'plenary.nvim' },
    config = util.setup.rc('todo_comments'),
  }

  use { 'lotabout/skim.vim',
    cmd = { 'Ag', 'Rg' },
  }

  use { 'ctrlpvim/ctrlp.vim',
    config = util.setup.rc('ctrlp'),
    cmd = { 'CtrlP' },
    keys = {
      { '<C-p>', mode = 'n' },
    },
  }
  use { 'numToStr/FTerm.nvim',
    config = util.setup.rc('fterm', 'ui'),
    cmd = { 'FTerm', 'Gitui', 'Top', 'Neofetch' },
  }

  use { 'mbbill/undotree',
    config = util.setup.rc('undotree'),
    cmd = { 'UndotreeToggle' },
  }
  use { 'y3owk1n/undo-glow.nvim',
    config = util.setup.rc('undo_glow', 'ui'),
    event = { 'VeryLazy' },
  }

  use { 'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = { 'plenary.nvim', 'nvim-web-devicons', 'nui.nvim' },
    config = util.setup.rc('neo_tree', 'ui'),
    cmd = { 'Neotree' },
  }
  use { 'luukvbaal/nnn.nvim',
    config = util.setup.rc('nnn', 'ui'),
    cond = util.cond.is_executable('nnn'),
    cmd = { 'NnnExplorer', 'NnnPicker' },
  }
  use { 'obaland/vfiler.vim',
    config = util.setup.rc('vfiler', 'ui'),
    dependencies = { 'obaland/vfiler-column-devicons' },
    cmd = { 'VFiler' },
  }
  use { 'xzbdmw/colorful-menu.nvim',
    config = util.setup.rc('colorful_menu', 'ui'),
  }

  use 'tpope/vim-fugitive'
  use { 'kyazdani42/nvim-web-devicons',
    config = util.setup.rc('devicons', 'ui'),
    lazy = true,
  }

  use { 'akinsho/bufferline.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = util.setup.mod_call('kiwi.ui.tabline'),
    event = { 'VimEnter' },
  }
  use { 'MunifTanjim/nougat.nvim',
    dependencies = {
      { 'SmiteshP/nvim-navic',
        dependencies = { 'nvim-lspconfig' },
      },
      'Pheon-Dev/pigeon',
    },
    config = util.setup.mod_call('kiwi.ui.bars'),
    event = { 'VimEnter' },
  }
  use {
    name = 'committia.nvim',
    url = 'https://gitlab.kokakiwi.net/contrib/neovim/committia.nvim.git',
  }
  use { 'rcarriga/nvim-notify',
    config = util.setup.rc('notify', 'ui'),
    priority = 100,
  }
  use { 'j-hui/fidget.nvim',
    config = util.setup.rc('fidget', 'ui'),
    priority = 100,
  }
  use { 'chentoast/marks.nvim',
    config = util.setup.rc('marks'),
    event = 'VeryLazy',
  }
  use { 'wfxr/minimap.vim',
    config = util.setup.rc('minimap', 'ui'),
    cond = util.cond.is_executable('code-minimap'),
    cmd = { 'Minimap', 'MinimapToggle' },
  }
  use { 'stevearc/aerial.nvim',
    config = util.setup.rc('aerial', 'ui'),
  }
  use { 'jinzhongjia/LspUI.nvim',
    config = util.setup.rc('lsp_ui', 'ui'),
  }
  use { 'uga-rosa/ccc.nvim',
    lazy = true,
    config = util.setup.rc('ccc', 'ui'),
    cmd = { 'CccPick' },
  }
  use { 'nvim-zh/colorful-winsep.nvim',
    config = util.setup.rc('colorful_winsep', 'ui'),
  }
  use { 'folke/noice.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    config = util.setup.rc('noice', 'ui'),
    event = { 'VeryLazy' },
  }
  use { 'melkster/modicator.nvim',
    dependencies = { 'catppuccin' },
    init = function()
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    config = util.setup.rc('modicator', 'ui'),
  }
  use { '3rd/image.nvim',
    cond = util.cond.has_module('magick'),
    config = util.setup.rc('image', 'ui'),
  }

  use { 'mvllow/modes.nvim',
    config = util.setup.rc('modes', 'ui'),
  }
  use { 'ray-x/guihua.lua',
    build = util.action.shell.make('lua/fzy'),
    lazy = true,
  }
  use { 'dstein64/nvim-scrollview',
    config = util.setup.rc('scrollview', 'ui'),
  }

  use { 'xeluxee/competitest.nvim',
    dependencies = { 'nui.nvim' },
    config = util.setup.rc('competitest', 'ui'),
  }

  use { 'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim',
      'tsakirist/telescope-lazy.nvim',
      'nvim-telescope/telescope-media-files.nvim',
      'aerial.nvim', 'nvim-notify', 'noice.nvim',
      'scope.nvim', 'persisted.nvim',
    },
    cmd = { 'Telescope' },
    config = util.setup.rc('telescope', 'ui'),
  }
  use { 'ray-x/navigator.lua',
    config = util.setup.rc('navigator', 'ui'),
    dependencies = { 'guihua.lua', 'nvim-lspconfig' },
    event = { 'LspAttach' },
  }
  use { 'stevearc/dressing.nvim',
    config = util.setup.rc('dressing', 'ui'),
    event = { 'VeryLazy' },
  }
  use { 'CosmicNvim/cosmic-ui',
    config = util.setup.rc('cosmic', 'ui'),
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim', 'nvim-lspconfig' },
    lazy = true,
  }
  use { 'tiagovla/scope.nvim',
    config = util.setup.rc('scope', 'ui'),
  }
  use { 'mhanberg/output-panel.nvim',
    event = 'VeryLazy',
    config = true,
  }

  use { 'goolord/alpha-nvim',
    dependencies = {
      { 'MaximilianLloyd/ascii.nvim',
        dependencies = { 'nui.nvim' },
      },
    },
    config = util.setup.mod_call('kiwi.ui.dashboard'),
    event = { 'VimEnter' },
  }

  use { 'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = util.setup.rc('gitsigns', 'ui'),
  }
  use { 'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = util.setup.rc('treesitter_context', 'ui'),
    event = { 'WinScrolled' },
  }
  use { 'Bekaboo/deadcolumn.nvim',
    config = util.setup.rc('deadcolumn', 'ui'),
  }
  use { 'anuvyklack/hydra.nvim',
    config = util.setup.rc('hydra', 'ui'),
  }

  use { 'giusgad/hologram.nvim',
    config = util.setup.rc('hologram', 'ui'),
    lazy = true,
  }
  use { 'giusgad/pets.nvim',
    dependencies = { 'nui.nvim', 'hologram.nvim' },
    config = util.setup.rc('pets', 'ui'),
  }
  use { 'utilyre/sentiment.nvim',
    config = util.setup.rc('sentiment', 'ui'),
  }

  use { 'eandrju/cellular-automaton.nvim',
    config = util.setup.rc('cellular_automaton', 'ui'),
    cmd = { 'CellularAutomaton' },
  }
  use { 'tamton-aquib/zone.nvim',
    config = util.setup.rc('zone', 'ui'),
    cmd = { 'Zone' },
  }
  use { 'cpea2506/relative-toggle.nvim',
    config = util.setup.rc('relative_toggle', 'ui'),
  }
end)
