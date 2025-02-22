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
    dependencies = { 'xzbdmw/colorful-menu.nvim' },
    config = util.setup.rc_mod_call('cmp'),
    event = { 'InsertEnter', 'CmdlineEnter' },
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

    if spec.lazy then
      use(spec)
    else
      table.insert(cmp.dependencies, spec)
    end
  end

  use(cmp)

  use { 'mfussenegger/nvim-dap',
    config = util.setup.rc('dap', 'helpers'),
  }
  use { 'rcarriga/nvim-dap-ui',
    dependencies = { 'nvim-dap' },
  }

  use { 'b0o/SchemaStore.nvim' }
  use { 'folke/neodev.nvim',
    dependencies = { 'nvim-dap-ui' },
    lazy = true,
  }
  use { 'folke/neoconf.nvim' }
  use { 'nvimtools/none-ls.nvim',
    dependencies = { 'plenary.nvim' },
    config = util.setup.rc('null_ls', 'helpers'),
    lazy = true,
  }
  use { 'MrcJkb/haskell-tools.nvim',
    dependencies = { 'nvim-lspconfig', 'plenary.nvim', 'telescope.nvim' },
    config = util.setup.rc('haskell_tools', 'helpers'),
    ft = { 'haskell' },
  }
  use { 'elixir-tools/elixir-tools.nvim',
    dependencies = { 'plenary.nvim' },
    version = '*',
    config = util.setup.rc('elixir', 'helpers'),
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'Elixir' },
  }
  use { 'mrshmllow/document-color.nvim',
    config = util.setup.rc('document_color', 'helpers'),
    lazy = true,
  }

  use { 'neovim/nvim-lspconfig',
    dependencies = { 'SchemaStore.nvim', 'neodev.nvim', 'rustowl' },
    config = util.setup.mod_setup('kiwi.lsp'),
  }
  use { 'icholy/lsplinks.nvim',
    config = util.setup.rc('lsplinks', 'helpers'),
  }
  use { 'cordx56/rustowl',
    lazy = true,
    config = util.setup.rc('rustowl', 'helpers'),
  }
  use {
    name = 'hook.nvim',
    url = 'https://gitlab.kokakiwi.net/contrib/neovim/hook.nvim.git',
  }
  use {
    name = 'nkey.nvim',
    url = 'https://gitlab.kokakiwi.net/contrib/neovim/nkey.nvim.git',
    dependencies = {
      'folke/which-key.nvim',
      'Cassin01/wf.nvim',
      'mrjones2014/legendary.nvim'
    },
    config = util.setup.rc('nkey', 'helpers'),
    priority = 100,
  }
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'folke/trouble.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = util.setup.rc('trouble', 'helpers'),
    cmd = { 'Trouble' },
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
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'yioneko/nvim-yati',
      'vim-illuminate',
    },
    event = { 'VeryLazy' },
  }
  use { 'nvim-treesitter/playground',
    dependencies = { 'nvim-treesitter' },
    cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor', 'TSNodeUnderCursor' },
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
    event = { 'VeryLazy' },
  }

  use { 'stevearc/conform.nvim',
    config = util.setup.rc('conform', 'helpers'),
  }
  use { 'stevearc/overseer.nvim',
    config = util.setup.rc('overseer', 'helpers'),
    lazy = true,
    cmd = {
      'OverseerInfo',
      'OverseerOpen', 'OverseerClose', 'OverseerToggle',
      'OverseerSaveBundle', 'OverseerLoadBundle', 'OverseerDeleteBundle',
      'OverseerRunCmd', 'OverseerRun', 'OverseerBuild',
      'OverseerQuickAction', 'OverseerTaskAction',
      'OverseerClearCache',
    },
  }

  use { 'nvim-neotest/neotest',
    config = util.setup.rc('neotest', 'helpers'),
    dependencies = {
      -- Dependencies
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',

      -- Plugins
      'nvim-neotest/neotest-python',
      'rouge8/neotest-rust',
    },
    cmd = { 'Neotest' },
  }

  use { 'junegunn/vim-easy-align',
    cmd = { 'EasyAlign' },
  }

end)
