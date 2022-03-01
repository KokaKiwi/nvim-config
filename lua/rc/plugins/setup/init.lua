local M = {}

function M.setup_better_whitespace()
  prefixed(vim.g, 'better_whitespace') {
    filetypes_blacklist = {
      'dashboard', 'NvimTree', 'packer', 'alpha',
      'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive',
    },
  }
end

function M.setup_blankline()
  require('indent_blankline').setup {
    buftype_exclude = { 'terminal', 'alpha', 'help', 'packer' },
    show_current_context = true,
  }
end

function M.setup_colorizer()
  require('colorizer').setup({
    'css', 'lua', 'vim',
    css = { css = true },
  }, {
    rgb_fn = true,
    hsl_fn = true,
  })
end

function M.setup_committia()
  prefixed(vim.g, 'committia') {
    open_only_vim_starting = 0,
    edit_window_width = 120,
    min_window_width = 240,
  }
end

function M.setup_crates()
  require('crates').setup {}

  vim.autocmd('BufRead', 'Cargo.toml', function()
    require('cmp').setup.buffer {
      sources = {
        { name = 'crates' },
      },
    }
  end)
end

function M.setup_ctrlp()
  prefixed(vim.g, 'ctrlp') {
    custom_ignore = {
      dir = '\\v[\\/](target|node_modules|_build)$',
    },
  }
end

function M.setup_glow()
  prefixed(vim.g, 'glow') {
    binary_path = '/usr/bin',
  }
end

function M.setup_gnupg()
  vim.g.GPGDefaultRecipients = { 'kokakiwi@kokakiwi.net' }
end

function M.setup_illuminate()
  prefixed(vim.g, 'Illuminate') {
    ftblacklist = { 'NvimTree' },
  }
end

function M.setup_lean()
  require('lean').setup {}
end

function M.setup_lint()
end

function M.setup_lsp_status()
  local lsp_status = require('lsp-status')

  lsp_status.register_progress()
end

function M.setup_marks()
  require('marks').setup {}
end

function M.setup_meadow()
  require('meadow').setup {}
end

function M.setup_navigator()
  require('navigator').setup {
    lsp = {
      disable_lsp = 'all',
      format_on_save = false,
      disply_diagnostic_qf = false,
      diagnostic_scrollbar_sign = false,
    },
  }
end

function M.setup_neoformat()
  prefixed(vim.g, 'neoformat') {
    enabled_c = { 'clang-format' },
    enabled_cpp = { 'clang-format' },
    enabled_python = { 'yapf', 'isort' },
    enabled_lua = { 'stylua' },
  }
end

function M.setup_polyglot()
  prefixed(vim.g, 'polyglot') {
    disabled = { 'fish', 'systemd' },
  }
end

function M.setup_presence()
  require('presence'):setup {
    file_assets = {
      ['Justfile'] = { 'Justfile', 'code' },
    },
  }
end

function M.setup_shade()
  require('shade').setup {}
end

function M.setup_todo_comments()
  require('todo-comments').setup {}
end

function M.setup_treesitter_context()
  require('treesitter-context').setup {
    patterns = {
      default = {
        'class',
        'function',
        'method',
      },
      rust = {
        'impl_item',
      },
    },
  }
end

function M.setup_trouble()
  require('trouble').setup {
    mode = 'document_diagnostics',
    use_diagnostic_signs = true,
  }
end

function M.setup_undotree()
  prefixed(vim.g, 'undotree') {
    SetFocusWhenToggle = true,
  }
end

function M.setup_vgit()
  require('vgit').setup {}
end

return M
