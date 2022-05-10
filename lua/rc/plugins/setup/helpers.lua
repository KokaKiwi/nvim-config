local M = {}

function M.setup_config_local()
  require('config-local').setup {}
end

function M.setup_headlines()
  require('headlines').setup {}
end

function M.setup_null_ls()
  local null_ls = require('null-ls')

  null_ls.setup {
    sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.completion.spell,
    },
  }
end

function M.setup_package_info()
  require('package-info').setup {
    hide_unstable_versions = true,
    package_manager = 'yarn',
  }
end

function M.setup_rust_tools()
  local config = kiwi.config.run('rust-tools:config', {
    cargo = {
      allFeatures = true,
    },
    checkOnSave = {
      command = 'clippy',
    },
    completion = {
      addCallArgumentSnippets = false,
      autoimport = { enable = false },
    },
  })

  local server = kiwi.config.run('rust-tools:server', {
    cmd_env = kiwi.config.run('rust-tools:env'),
    settings = {
      ['rust-analyzer'] = config,
    },
  })

  require('rust-tools').setup {
    tools = {
      hover_with_actions = false,
      inlay_hints = {
        other_hints_prefix = '» ',
        highlight = 'NonText',
      },
    },

    server = server,
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

  configs.make = {
    install_info = {
      url = 'https://github.com/alemuller/tree-sitter-make',
      branch = 'main',
      files = { 'src/parser.c' },
    },
  }
  configs.norg = {
    install_info = {
      url = 'https://github.com/nvim-neorg/tree-sitter-norg',
      branch = 'main',
      files = { 'src/scanner.cc', 'src/parser.c' },
    },
    maintainers = { '@IndianBoy42' },
  }
  configs.just = {
    install_info = {
      url = 'https://github.com/IndianBoy42/tree-sitter-just',
      branch = 'main',
      files = { 'src/scanner.cc', 'src/parser.c' },
    },
  }

  require('nvim-treesitter.configs').setup {
    ensure_installed = 'all',
    ignore_install = { 'ocamllex' },
    highlight = {
      enable = true,
    },
    playground = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
    },
  }

  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end

return M
