local M = {}

function M.setup_dap()
end

function M.setup_diffview(_plugin, opts)
  local config = vim.tbl_deep_extend('force', opts, {})
  require('diffview').setup(config)
end

function M.setup_document_color()
  require('document-color').setup {}
end

function M.setup_haskell_tools()
  local ht = require('haskell-tools')

  ht.setup {}
end

function M.setup_headlines()
  require('headlines').setup {}
end

function M.setup_lspsaga()
  local cat = require('catppuccin.groups.integrations.lsp_saga')
  local nkey = require('nkey')

  local saga_command = function(name)
    return function()
      require('lspsaga.command').load_command(name)
    end
  end

  local lspsaga = {
    code_action = saga_command('code_action'),
    show_line_diagnostics = saga_command('show_line_diagnostics'),
    lsp_finder = saga_command('lsp_finder'),
    hover_doc = saga_command('hover_doc'),
    rename = saga_command('rename'),
    preview_definition = saga_command('preview_definition'),
  }

  require('lspsaga').setup {
    finder_action_keys = {
      open = { '<CR>', 'o' },
    },
    ui = {
      kind = cat.custom_kind(),
    },
    symbol_in_winbar = {
      enable = false,
    },
    lightbulb = {
      enable_in_insert = false,
    },
  }

  nkey.register {
    { '<Leader>', {
      { 'ca', lspsaga.code_action, help = 'Code Action [LSP]' },
      { 'cd', lspsaga.show_line_diagnostics, help = 'Show diagnostics [LSP]' },
      { 'cD', lspsaga.preview_definition, help = 'Preview definition [LSP]' },
    } },
    { 'g', {
      { 'h', lspsaga.lsp_finder, help = 'Find references and definitions [LSP]' },
      { 'K', lspsaga.hover_doc, help = 'Display doc [LSP]' },
      { 'R', lspsaga.rename, help = 'Rename symbol [LSP]' },
    } },
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
    branch_separator = '@@',
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

  configs.nu = {
    install_info = {
      url = 'https://github.com/LhKipp/tree-sitter-nu',
      branch = 'main',
      files = { 'src/scanner.c', 'src/parser.c' },
    },
    filetype = 'nu',
  }
  configs.just = {
    install_info = {
      url = 'https://gitlab.kokakiwi.net/contrib/neovim/tree-sitter-just',
      branch = 'main',
      files = { 'src/scanner.cc', 'src/parser.c' },
    },
  }
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
  configs.typst = {
    install_info = {
      url = 'https://github.com/SeniorMars/tree-sitter-typst.git',
      branch = 'main',
      files = { 'src/scanner.c', 'src/parser.c' },
    },
    filetype = 'typst',
  }

  require('nvim-treesitter.configs').setup {
    ensure_installed = 'all',
    ignore_install = { 'ocamllex' },
    highlight = {
      enable = true,
      disable = { 'lua', 'make' },
    },
    playground = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
    },
    yati = {
      enable = true,
    },
    indent = {
      enable = false,
    },
  }

  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end

function M.setup_trouble()
  require('trouble').setup {
    mode = 'document_diagnostics',
    use_diagnostic_signs = true,
  }
end

return M
