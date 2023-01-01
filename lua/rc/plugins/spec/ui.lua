local util = require('rc.plugins.util')

return util.module('ui', function(use)
  use { 'RRethy/vim-illuminate',
    config = util.setup.rc('illuminate'),
  }
  use { 'norcalli/nvim-colorizer.lua',
    config = util.setup.rc('colorizer'),
  }
  use { 'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPre' },
    config = util.setup.rc('blankline'),
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
      { 'n', '<C-p>' },
    },
  }
  use 'ripxorip/aerojump.nvim'
  use { 'numToStr/FTerm.nvim',
    config = util.setup.rc('fterm', 'ui'),
    cmd = { 'FTerm', 'Gitui', 'Top', 'Neofetch' },
  }

  use { 'mbbill/undotree',
    config = util.setup.rc('undotree'),
    cmd = { 'UndotreeToggle' },
  }

  use { 'kyazdani42/nvim-tree.lua',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = util.setup.rc('nvim_tree', 'ui'),
  }
  use { 'luukvbaal/nnn.nvim',
    config = util.setup.rc('nnn', 'ui'),
    cond = util.cond.is_executable('nnn'),
    cmd = { 'NnnExplorer', 'NnnPicker' },
  }
  use { 'LudoPinelli/comment-box.nvim',
    config = util.setup.rc('comment_box', 'ui'),
  }

  use 'tpope/vim-fugitive'
  use { 'kyazdani42/nvim-web-devicons',
    config = util.setup.rc('devicons', 'ui'),
  }
  use { 'robert-oleynik/git-blame-virt.nvim',
    config = util.setup.rc('git_blame_virt', 'ui'),
  }

  use { 'akinsho/nvim-bufferline.lua',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = util.setup.mod_call('kiwi.ui.tabline'),
    event = { 'VimEnter' },
  }
  use { 'feline-nvim/feline.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = util.setup.mod_call('kiwi.ui.statusline'),
  }
  use { 'nvim-lua/lsp-status.nvim',
    config = util.setup.rc('lsp_status'),
  }
  use { 'folke/which-key.nvim' }
  use { 'mrjones2014/legendary.nvim' }
  use { 'rcarriga/nvim-notify',
    dependencies = { 'nvim-bufferline.lua' },
    config = util.setup.rc('notify', 'ui'),
  }
  use { 'chentoast/marks.nvim',
    config = util.setup.rc('marks'),
  }
  use { 'wfxr/minimap.vim',
    config = util.setup.rc('minimap', 'ui'),
    cond = util.cond.is_executable('code-minimap'),
    cmd = { 'Minimap', 'MinimapToggle' },
  }
  use { 'stevearc/aerial.nvim',
    config = util.setup.rc('aerial', 'ui'),
  }
  use { 'uga-rosa/ccc.nvim',
    config = util.setup.rc('ccc', 'ui'),
  }
  use { 'nvim-zh/colorful-winsep.nvim',
    config = util.setup.rc('colorful_winsep', 'ui'),
  }
  use { 'folke/noice.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
    config = util.setup.rc('noice', 'ui'),
  }

  use { 'mvllow/modes.nvim',
    config = util.setup.rc('modes', 'ui'),
  }

  use { 'xeluxee/competitest.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = util.setup.rc('competitest', 'ui'),
  }

  use { 'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim',
      'aerial.nvim', 'nvim-notify', 'noice.nvim',
    },
    cmd = { 'Telescope' },
    config = util.setup.rc('telescope', 'ui'),
  }
  use { 'ray-x/navigator.lua',
    config = util.setup.rc('navigator'),
    dependencies = {
      { 'ray-x/guihua.lua',
        build = util.action.shell.make('lua/fzy'),
      },
      'neovim/nvim-lspconfig',
    },
  }
  use { 'stevearc/dressing.nvim',
    config = util.setup.rc('dressing', 'ui'),
  }
  use { 'CosmicNvim/cosmic-ui',
    config = util.setup.rc('cosmic', 'ui'),
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim', 'nvim-lspconfig' },
  }

  use { 'rhysd/committia.vim',
    config = util.setup.rc('committia'),
    event = { 'BufReadPost COMMIT_EDITMSG,MERGE_MSG' },
  }

  use { 'goolord/alpha-nvim',
    config = util.setup.mod_call('kiwi.ui.dashboard'),
    event = { 'VimEnter' },
  }

  use { 'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = util.setup.rc('gitsigns', 'ui'),
  }
  use { 'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = util.setup.rc('treesitter_context'),
  }
  use { 'lukas-reineke/virt-column.nvim',
    config = util.setup.rc('virt_column', 'ui'),
  }
  use { 'lewis6991/satellite.nvim',
    config = util.setup.rc('satellite', 'ui'),
  }
  use { 'anuvyklack/hydra.nvim',
    config = util.setup.rc('hydra', 'ui'),
  }
end)
