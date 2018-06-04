local util = require('rc.plugins.util')

-- Setup
local packer = util.require_packer()

local has_colorscheme = nil
packer.set_handler('colorscheme', function(_, plugin, value)
  if value == nil then
    return
  end
  assert(has_colorscheme == nil, 'Colorscheme is already set')

  if type(plugin.config) == 'string' then
    plugin.config = string.format('%s\nvim.cmd [[colorscheme %s]]', plugin.config, value)
  else
    local old_config = plugin.config
    plugin.config = function()
      old_config()
      vim.cmd(string.format('colorscheme %s', value))
    end
  end

  has_colorscheme = value
end)

return packer.startup {
  config = {
    max_jobs = 8,
    display = {
      open_fn = function()
        return require('packer.util').float {}
      end,
    },
  },
  function(use, use_rocks)
    use 'wbthomason/packer.nvim'

    -- Utils
    use 'editorconfig/editorconfig-vim'
    use { 'glts/vim-radical',
      requires = { 'glts/vim-magnum' },
      keys = {
        { 'n', 'gA' },
        { 'n', 'crd' },
        { 'n', 'crx' },
        { 'n', 'cro' },
        { 'n', 'crb' },
      }
    }
    use 'hynek/vim-python-pep8-indent'
    use 'jamessan/vim-gnupg'
    use 'justinmk/vim-sneak'
    use 'mattn/emmet-vim'
    use { 'mattn/vim-gist',
      requires = { 'mattn/webapi-vim' },
      cmd = { 'Gist' },
    }
    use 'ntpeters/vim-better-whitespace'
    use { 'nvim-lua/plenary.nvim',
      module = { 'plenary' },
    }
    use { 'nvim-lua/popup.nvim',
      module = { 'popup' },
    }
    use 'prabirshrestha/async.vim'
    use 'terryma/vim-multiple-cursors'
    use 'tpope/vim-repeat'
    use 'tpope/vim-sensible'
    use 'tpope/vim-surround'
    use { 'stsewd/isort.nvim',
      run = util.action.cmd('UpdateRemotePlugins'),
    }
    use { 'famiu/bufdelete.nvim',
      cmd = { 'Bdelete', 'Bwipeout' },
      module = { 'bufdelete' },
    }
    use { 'jghauser/mkdir.nvim',
      config = util.setup.mod('mkdir'),
    }
    use { 'b3nj5m1n/kommentary',
      config = util.setup.rc('kommentary'),
      keys = {
        { 'n', '<leader>c' },
        { 'x', '<leader>c' },
      },
    }
    use { 'LionC/nest.nvim',
      config = util.setup.mod('rc.init.keymaps'),
    }
    use { 'henriquehbr/nvim-startup.lua',
      config = util.setup.rc('nvim_startup'),
      after = { 'nvim-notify' },
    }
    use { 'andweeb/presence.nvim',
      config = util.setup.rc('presence'),
    }

    use 'inkarkat/vim-ingo-library'
    use 'LucHermitte/lh-vim-lib'

    use { 'rafcamlet/nvim-luapad' }
    use { 'tjdevries/nlua.nvim' }

    use { 'iamcco/markdown-preview.nvim',
      ft = { 'markdown', 'pandoc.markdown', 'rmd' },
      run = util.action.call('mkdp#util#install'),
    }
    use { 'ellisonleao/glow.nvim',
      cmd = { 'Glow' },
    }
    use { 'nvim-neorg/neorg',
      config = util.setup.rc_mod('neorg'),
      requires = { 'nvim-lua/plenary.nvim' },
    }

    use 'lewis6991/impatient.nvim'

    -- Helpers (autocomplete, lint, format, snippets)
    use { 'liuchengxu/vista.vim', cmd = { 'Vista' } }
    use 'mhinz/vim-mix-format'

    use { 'saecki/crates.nvim',
      branch = 'main',
      requires = { 'nvim-lua/plenary.nvim' },
      event = { 'BufRead Cargo.toml' },
      config = util.setup.rc('crates'),
    }

    use { 'hrsh7th/nvim-cmp',
      requires = { 'hrsh7th/vim-vsnip', 'onsails/lspkind-nvim' },
      config = util.setup.rc('cmp'),
    }
    local CMP_BASE_SOURCES = {
      'nvim-lsp', 'nvim-lua', 'vsnip', 'buffer',
      'path', 'emoji', 'cmdline',
    }
    for _, name in ipairs(CMP_BASE_SOURCES) do
      use { 'hrsh7th/cmp-' .. name,
        after = { 'nvim-cmp' },
      }
    end
    use { 'ray-x/cmp-treesitter',
      after = { 'nvim-cmp' },
    }

    use { 'simrat39/rust-tools.nvim',
      config = util.setup.rc('rust_tools'),
      after = { 'nvim-lspconfig' },
    }
    use 'b0o/SchemaStore.nvim'

    use { 'neovim/nvim-lspconfig',
      config = util.setup.mod_setup('kiwi.lsp'),
      after = { 'cmp-nvim-lsp', 'SchemaStore.nvim' },
    }
    use { 'folke/trouble.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = util.setup.rc('trouble'),
      cmd = { 'Trouble', 'TroubleToggle' },
    }
    use { 'mfussenegger/nvim-lint',
      config = util.setup.rc('lint'),
    }

    use { 'nvim-treesitter/nvim-treesitter',
      run = util.action.cmd('TSUpdate'),
      config = util.setup.rc('treesitter'),
    }
    use { 'nvim-treesitter/playground',
      requires = { 'nvim-treesitter/nvim-treesitter' },
    }
    use { 'Julian/lean.nvim',
      config = util.setup.rc('lean'),
      after = { 'nvim-lspconfig' },
    }

    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

    use { 'sbdchd/neoformat',
      cmd = { 'Neoformat' },
    }

    use 'jiangmiao/auto-pairs'
    use 'junegunn/vim-easy-align'

    -- UI
    -- UI > Colorschemes
    use { 'rktjmp/lush.nvim',
      module = { 'lush' },
    }

    use { 'olimorris/onedarkpro.nvim',
      config = util.setup.rc('onedark'),
      -- colorscheme = 'onedark',
    }
    use { 'Pocco81/Catppuccino.nvim',
      config = util.setup.rc('catppuccino'),
      colorscheme = 'catppuccino',
    }

    -- UI > Misc
    use { 'RRethy/vim-illuminate',
      module = { 'illuminate' },
    }
    use { 'norcalli/nvim-colorizer.lua',
      config = util.setup.rc('colorizer'),
    }
    use { 'lukas-reineke/indent-blankline.nvim',
      event = { 'BufReadPre' },
      config = util.setup.rc('blankline'),
    }
    use { 'folke/todo-comments.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = util.setup.rc('todo_comments'),
    }

    use { 'lotabout/skim.vim',
      cmd = { 'Ag', 'Rg' },
    }

    use { 'ctrlpvim/ctrlp.vim',
      cmd = { 'ctrlp' },
      keys = {
        { 'n', '<C-p>' },
      },
    }
    use 'ripxorip/aerojump.nvim'
    use { 'numToStr/FTerm.nvim',
      config = util.setup.rc('fterm'),
      cmd = { 'FTerm', 'Gitui', 'Top' },
    }

    use { 'mbbill/undotree',
      cmd = { 'UndotreeToggle' },
    }

    use { 'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = util.setup.rc('nvim_tree'),
      cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFocus' },
    }
    use 'tpope/vim-fugitive'
    use 'ryanoasis/vim-devicons'
    use { 'kyazdani42/nvim-web-devicons',
      config = util.setup.rc('devicons'),
    }

    use { 'akinsho/nvim-bufferline.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = util.setup.mod_setup('kiwi.ui.tabline'),
      event = { 'VimEnter' },
    }
    use { 'glepnir/galaxyline.nvim',
      branch = 'main',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = util.setup.mod_setup('kiwi.ui.statusline'),
    }
    use { 'nvim-lua/lsp-status.nvim',
      config = util.setup.rc('lsp_status'),
      module = { 'lsp-status' },
    }
    use { 'weilbith/nvim-code-action-menu',
      cmd = { 'CodeActionMenu' },
    }
    use { 'folke/which-key.nvim',
      config = util.setup.rc('which_key'),
    }
    use { 'code-biscuits/nvim-biscuits',
      config = util.setup.rc('biscuits'),
    }
    use { 'rcarriga/nvim-notify',
      config = util.setup.rc_mod('notify'),
      after = { 'onedarkpro.nvim', 'nvim-bufferline.lua' },
    }
    use { 'chentau/marks.nvim',
      config = util.setup.rc('marks'),
    }

    use { 'nvim-telescope/telescope.nvim',
      requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
      module = { 'telescope' },
      cmd = { 'Telescope' },
      config = util.setup.rc('telescope'),
      keys = {
        { 'n', '<leader>ff' },
        { 'n', '<leader>fg' },
        { 'n', '<leader>fh' },
      }
    }
    use { 'ray-x/navigator.lua',
      config = util.setup.rc('navigator'),
      requires = {
        { 'ray-x/guihua.lua',
          run = 'cd lua/fzy && make',
        },
        'neovim/nvim-lspconfig',
      },
      after = { 'nvim-lspconfig' },
    }
    use 'rhysd/committia.vim'
    use { 'tanvirtin/vgit.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = util.setup.rc('vgit'),
      event = { 'BufWinEnter' },
      cmd = { 'VGit' },
    }

    use { 'goolord/alpha-nvim',
      config = util.setup.mod_setup('kiwi.ui.dashboard'),
      event = { 'VimEnter' },
    }

    use { 'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = util.setup.rc('gitsigns'),
    }
    use { 'romgrk/nvim-treesitter-context',
      config = util.setup.rc('treesitter_context'),
      requires = { 'nvim-treesitter/nvim-treesitter' },
    }

    -- Syntax / Languages
    use 'godlygeek/tabular'

    use 'sheerun/vim-polyglot'

    use { 'PProvost/vim-ps1', ft = { 'ps1', 'ps1xml' } }
    use { 'bytecodealliance/cranelift.vim', ft = 'clif', branch = 'main' }
    use { 'eiginn/iptables-vim', ft = 'iptables' }
    use { 'fedorenchik/qt-support.vim' }
    use { 'gisphm/vim-gitignore', ft = 'gitignore'}
    use { 'gleam-lang/gleam.vim', ft = 'gleam' }
    use { 'hail2u/vim-css3-syntax', ft = 'css' }
    use { 'hjson/vim-hjson', ft = 'hjson'}
    use { 'jceb/vim-orgmode', ft = 'orgmode'}
    use { 'justinj/vim-pico8-syntax', ft = 'pico8' }
    use { 'kelwin/vim-smali', ft = 'smali' }
    use { 'killphi/vim-ebnf', ft = 'ebnf' }
    use { 'leanprover/lean.vim', ft = 'lean' }
    use { 'metakirby5/codi.vim' }
    use { 'moon-musick/vim-logrotate', ft = 'logrotate' }
    use { 'niklasl/vim-rdf', ft = 'rdf' }
    use { 'nikvdp/ejs-syntax', ft = { 'ejs' } }
    use { 'projectfluent/fluent.vim', ft = 'fluent' }
    use { 'ron-rs/ron.vim', ft = 'ron' }
    use { 'thyrgle/vim-dyon', ft = 'dyon' }
    use { 'cstrahan/vim-capnp', ft = 'capnp' }

    -- LuaRocks
    use_rocks { 'luasocket', 'luaposix' }

    -- Automatically setup config after bootstraping packer.nvim
    if packer._bootstrap then
      packer.sync()
    end
  end
}
