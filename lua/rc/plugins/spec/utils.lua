local util = require('rc.plugins.util')

return util.module('utils', function(use)
  use 'editorconfig/editorconfig-vim'

  use { 'glts/vim-radical',
    dependencies = { 'glts/vim-magnum' },
    keys = {
      { 'n', 'gA' },
      { 'n', 'crd' },
      { 'n', 'crx' },
      { 'n', 'cro' },
      { 'n', 'crb' },
    },
  }
  use 'hynek/vim-python-pep8-indent'

  use { 'jamessan/vim-gnupg',
    config = util.setup.rc('gnupg'),
  }
  use 'mattn/emmet-vim'
  use { 'ntpeters/vim-better-whitespace',
    config = util.setup.rc('better_whitespace'),
  }

  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'

  use 'prabirshrestha/async.vim'
  use 'mg979/vim-visual-multi'
  use 'tpope/vim-repeat'
  use 'tpope/vim-sensible'
  use 'tpope/vim-surround'
  use 'stsewd/isort.nvim'

  use { 'famiu/bufdelete.nvim',
    cmd = { 'Bdelete', 'Bwipeout' },
  }
  use { 'jghauser/mkdir.nvim',
    config = util.setup.mod('mkdir'),
  }
  use { 'numToStr/Comment.nvim',
    config = util.setup.rc('Comment', 'utils'),
  }
  use { 'andweeb/presence.nvim',
    config = util.setup.rc('presence'),
  }
  use { 'direnv/direnv.vim',
    cond = util.cond.is_executable('direnv'),
  }
  use { 'lkemitchll/kitty-runner.nvim',
    config = util.setup.rc('kitty_runner', 'utils'),
  }
  use { 'krivahtoo/silicon.nvim',
    config = util.setup.rc('silicon', 'utils'),
    build = {
      './install.sh',
    },
  }

  use 'inkarkat/vim-ingo-library'
  use 'LucHermitte/lh-vim-lib'

  use { 'rafcamlet/nvim-luapad',
    cmd = { 'Luapad', 'Luarun' },
  }
  use { 'metakirby5/codi.vim',
    cmd = { 'Codi' },
  }
  use { 'sQVe/sort.nvim',
    config = util.setup.rc('sort', 'utils'),
    cmd = { 'Sort' },
  }
  use { 'booperlv/nvim-gomove',
    config = util.setup.rc('gomove', 'utils'),
  }

  use { 'ellisonleao/glow.nvim',
    config = util.setup.rc('glow'),
    cmd = { 'Glow' },
    cond = util.cond.is_executable('glow'),
  }
  use { 'ray-x/viewdoc.nvim',
    dependencies = { 'guihua.lua' },
    config = util.setup.rc('viewdoc', 'utils'),
    cmd = { 'Viewdoc' },
    cond = util.cond.all(
      util.cond.is_executable('fd'),
      util.cond.is_executable('glow')
    ),
  }
  use { 'nvim-neorg/neorg',
    config = util.setup.rc('neorg', 'utils'),
    dependencies = { 'plenary.nvim' },
    ft = { 'norg' },
  }
  use { 'thazelart/figban.nvim',
    cmd = { 'Figban' },
    cond = util.cond.is_executable('figlet'),
  }
end)
