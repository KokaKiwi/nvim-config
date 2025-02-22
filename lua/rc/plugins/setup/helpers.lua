local M = {}

function M.setup_conform()
  require('conform').setup {
    formatters_by_ft = {
      python = {
        formatters = { 'isort' },
        run_all_formatters = true,
      },
    },
  }
end

function M.setup_dap()
end

function M.setup_diffview(_plugin, opts)
  local config = vim.tbl_deep_extend('force', opts, {})
  require('diffview').setup(config)
end

function M.setup_document_color()
  require('document-color').setup {}
end

function M.setup_elixir()
  require('elixir').setup {
    nextls = {
      enable = false,
    },
    credo = {
      enable = false,
    },
    elixirls = {
      enable = false,
      cmd = '/usr/bin/elixir-ls',
    },
  }
end

function M.setup_haskell_tools()
end

function M.setup_headlines()
  require('headlines').setup {}
end

function M.setup_lsplinks()
  local lsplinks = require('lsplinks')
  lsplinks.setup()

  require('nkey').register {
    { 'gx', lsplinks.gx },
  }
end

function M.setup_neotest()
  local neotest = require('neotest')

  neotest.setup {
    adapters = {
      require('neotest-python'),
      require('neotest-rust'),
    },
  }

  vim.api.nvim_create_user_command('Neotest', function(opts)
    neotest.run.run(opts.args)
  end, {
    desc = 'Run nearest test',
  })
end

function M.setup_nkey()
  require('which-key').setup {
    notify = false,
  }

  require('nkey').setup {
    integrations = {
      'legendary',
      'which_key',
    },
  }
end

function M.setup_null_ls()
  local null_ls = require('null-ls')

  null_ls.setup {
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.eslint,
    },
  }
end

function M.setup_overseer()
  require('overseer').setup {
    templates = { 'builtin' },
  }
end

function M.setup_package_info()
  require('package-info').setup {
    hide_unstable_versions = true,
    package_manager = 'yarn',
  }
end

function M.setup_persisted()
  require('persisted').setup {
    save_dir = vim.fn.stdpath('state') .. '/sessions/',
    autosave = false,
    use_git_branch = true,
  }
end

function M.setup_rustowl()
  local rustowl = require('rustowl')

  vim.api.nvim_create_user_command('RustOwl', function()
    rustowl.rustowl_cursor()
  end, {})

  require('nkey').register {
    { '<c-O>', function()
      print('hello')
      rustowl.rustowl_cursor()
    end},
  }
end

function M.setup_snippy()
  require('snippy').setup {
    mappings = {
      is = {
        ['<Tab>'] = 'expand_or_advance',
        ['<S-Tab>'] = 'previous',
      },
    },
  }
end

function M.setup_treesitter()
  local configs = require('nvim-treesitter.parsers').get_parser_configs()

  configs.kwconfig = {
    install_info = {
      url = 'https://gitlab.kokakiwi.net/grape/tree-sitter-kwconfig.git',
      branch = 'main',
      files = { 'src/parser.c' },
    },
  }
  configs.witx = {
    install_info = {
      url = 'https://gitlab.kokakiwi.net/kokakiwi/tree-sitter-witx.git',
      branch = 'main',
      files = { 'src/parser.c' }
    },
  }

  require('ts_context_commentstring').setup {}
  vim.g.skip_ts_context_commentstring_module = true

  require('nvim-treesitter.configs').setup {
    auto_install = true,
    ignore_install = { 'ocamllex' },
    highlight = {
      enable = true,
      disable = { 'lua', 'make' },
    },
    playground = {
      enable = true,
    },
    yati = {
      enable = true,
    },
    indent = {
      enable = false,
    },
  }

  vim.o.foldmethod = 'expr'
  vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
end

function M.setup_trouble()
  require('trouble').setup {
    mode = 'document_diagnostics',
    use_diagnostic_signs = true,
  }
end

return M
