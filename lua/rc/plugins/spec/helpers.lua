local util = require('rc.plugins.util')

return util.module('helpers', function(use)
  use { 'mhinz/vim-mix-format' }

  use { 'saecki/crates.nvim',
    dependencies = { 'plenary.nvim', 'nvim-cmp' },
    event = { 'BufRead Cargo.toml' },
    config = util.setup.rc('crates'),
  }
  use { 'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = util.setup.rc('package_info', 'helpers'),
    event = { 'BufRead package.json' },
  }

  local cmp = { 'hrsh7th/nvim-cmp',
    dependencies = { 'onsails/lspkind-nvim' },
    config = util.setup.rc_mod_call('cmp'),
  }

  local CMP_SOURCES = {
    { 'nvim-lsp',
      dependencies = { 'nvim-lspconfig' },
    },
    'nvim-lsp-document-symbol', 'nvim-lsp-signature-help',
    'nvim-lua',
    'buffer', 'path', 'emoji', 'cmdline', 'calc',
    'ray-x/cmp-treesitter', 'David-Kunz/cmp-npm', 'kdheepak/cmp-latex-symbols',
    'dcampos/cmp-snippy',
  }
  for _, spec in ipairs(CMP_SOURCES) do
    if type(spec) == 'string' then
      spec = { spec }
    end

    if spec[1]:find('/') == nil then
      spec[1] = 'hrsh7th/cmp-' .. spec[1]
    end

    table.insert(cmp.dependencies, spec)
  end
  use(cmp)

  use { 'simrat39/rust-tools.nvim',
    dependencies = { 'nvim-lspconfig' },
    config = util.setup.rc('rust_tools', 'helpers'),
    ft = { 'rust' },
  }
  use { 'b0o/SchemaStore.nvim' }
  use { 'folke/neodev.nvim',
    lazy = true,
  }
  use { 'folke/neoconf.nvim' }
  use { 'jose-elias-alvarez/null-ls.nvim',
    dependencies = { 'plenary.nvim' },
    config = util.setup.rc('null_ls', 'helpers'),
    lazy = true,
  }
  use { 'MrcJkb/haskell-tools.nvim',
    dependencies = { 'nvim-lspconfig', 'plenary.nvim', 'telescope.nvim' },
    config = util.setup.rc('haskell_tools', 'helpers'),
    ft = { 'haskell' },
  }
  use { 'mrshmllow/document-color.nvim',
    config = util.setup.rc('document_color', 'helpers'),
  }

  use { 'neovim/nvim-lspconfig',
    dependencies = { 'SchemaStore.nvim', 'neodev.nvim' },
    config = util.setup.mod_setup('kiwi.lsp'),
  }
  use { 'glepnir/lspsaga.nvim',
    dependencies = { 'nvim-lspconfig' },
    config = util.setup.rc('lspsaga', 'helpers'),
  }
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'folke/trouble.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = util.setup.rc('trouble'),
    cmd = { 'Trouble', 'TroubleToggle' },
  }
  use { 'mfussenegger/nvim-lint',
    config = util.setup.rc('lint'),
  }

  use { 'sindrets/diffview.nvim',
    config = util.setup.rc('diffview', 'helpers'),
  }

  use { 'nvim-treesitter/nvim-treesitter',
    build = function()
      if not klib.is_nvim_headless() then
        vim.cmd('TSUpdate')
      end
    end,
    config = util.setup.rc('treesitter', 'helpers'),
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
  }
  use { 'nvim-treesitter/playground',
    dependencies = { 'nvim-treesitter' },
  }
  use { 'Julian/lean.nvim',
    ft = { 'lean', 'lean3', 'leaninfo' },
    config = util.setup.rc('lean'),
    dependencies = { 'nvim-lspconfig' },
  }
  use { 'lukas-reineke/headlines.nvim',
    config = util.setup.rc('headlines', 'helpers'),
    ft = { 'markdown', 'rmd', 'vimwiki', 'org' },
  }

  use { 'dcampos/nvim-snippy',
    config = util.setup.rc('snippy', 'helpers'),
  }
  use { 'olimorris/persisted.nvim',
    config = util.setup.rc('persisted', 'helpers'),
    dependencies = { 'telescope.nvim' },
  }

  use { 'sbdchd/neoformat',
    config = util.setup.rc('neoformat'),
    cmd = { 'Neoformat' },
  }
  use { 'stevearc/overseer.nvim',
    config = util.setup.rc('overseer', 'helpers'),
  }

  use { 'nvim-neotest/neotest',
    config = util.setup.rc('neotest', 'helpers'),
    dependencies = {
      -- Dependencies
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',

      -- Plugins
      'rouge8/neotest-rust',
    },
  }

  use { 'jiangmiao/auto-pairs' }
  use { 'junegunn/vim-easy-align',
    cmd = { 'EasyAlign' },
  }

end)
