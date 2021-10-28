local M = {}

function M.setup_blankline()
  require('indent_blankline').setup {
    buftype_exclude = { 'terminal', 'alpha', 'help' },
    show_current_context = true,
  }
end

function M.setup_catppuccino()
  local catppuccino = require('catppuccino')
  -- local util = require('catppuccino.utils.util')

  local colorscheme = 'dark_catppuccino'
  local err, colors = require('catppuccino.api.colors').get_colors(colorscheme)
  if not err.status then
    error(string.format('Unknown colorscheme: %s', colorscheme))
  end

  catppuccino.setup {
    colorscheme = colorscheme,
    term_colors = true,
    styles = {
      functions = 'bold,italic',
      keywords = 'italic',
    },
    integrations = {
      lsp_trouble = true,
      gitsigns = true,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = true,
      },
      which_key = true,
      indent_blankline = {
        enabled = true,
      },
      dashboard = true,
      bufferline = true,
    },
  }

  catppuccino.remap(colors, {
    Constant = { fg = colors.orange, style = 'italic' },

    TSBoolean = { fg = colors.orange, style = 'italic' },
  })
end

function M.setup_colorizer()
  require('colorizer').setup({
    'css', 'lua';
    css = { css = true },
  }, {
    rgb_fn = true,
    hsl_fn = true,
  })
end

function M.setup_cmp()
  local cmp = require('cmp')
  local lspkind = require('lspkind')

  local BASE_SOURCES = {
    { name = 'path' },
    { name = 'buffer' },
    { name = 'emoji' },
    { name = 'latex_symbols' },
  }

  cmp.setup {
    sources = cmp.config.sources(
      {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
      },
      BASE_SOURCES
    ),
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<Tab>'] = cmp.mapping {
        i = cmp.mapping.confirm { select = true },
      },
      ['<CR>'] = cmp.mapping {
        -- i = cmp.mapping.confirm { select = true },
        c = cmp.mapping.confirm { select = false },
      },
      ['<C-e>'] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ['<C-Up>'] = cmp.mapping {
        c = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
      },
      ['<C-Down>'] = cmp.mapping {
        c = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
      },
    },
    formatting = {
      format = lspkind.cmp_format {},
    }
  }

  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' },
    },
  })
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources(
      {
        { name = 'path' },
      },
      {
        { name = 'cmdline' },
      }
    ),
    completion = {
      keyword_length = 2,
    },
  })

  vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'noselect', 'preview' }

  vim.aufiletype('lua', function()
    cmp.setup.buffer {
      sources = cmp.config.sources(
        {
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'vsnip' },
        },
        BASE_SOURCES
      ),
    }
  end)

  vim.autocmd('BufRead', 'Cargo.toml', function()
    cmp.setup.buffer {
      sources = cmp.config.sources(
        {
          { name = 'crates' },
        },
        BASE_SOURCES
      ),
    }
  end)
  vim.autocmd('BufRead', 'package.json', function()
    cmp.setup.buffer {
      sources = cmp.config.sources(
        {
          { name = 'npm' },
        },
        BASE_SOURCES
      )
    }
  end)
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

function M.setup_devicons()
  require('nvim-web-devicons').setup {
    default = true,
  }
end

function M.setup_fterm()
  local FTerm = require('FTerm')

  _G.fterm = {
    term = FTerm:new {
      border = 'double',
      dimensions = {
        width = 0.9,
        height = 0.9,
      },
    },
    gitui = FTerm:new {
      cmd = 'gitui',
      border = 'double',
      dimensions = {
        width = 0.9,
        height = 0.9,
      },
    },
    top = FTerm:new {
      cmd = 'bpytop',
      border = 'double',
      dimensions = {
        width = 0.9,
        height = 0.9,
      },
    },
    neofetch = FTerm:new {
      cmd = 'neofetch && read',
      blend = 75,
      dimensions = {
        width = 0.5,
        height = 0.55,
        x = 1,
        y = 0.9,
      },
    },
  }

  local function toggle(term)
    return function() term:toggle() end
  end

  vim.command('FTerm', toggle(fterm.term))
  vim.command('Gitui', toggle(fterm.gitui))
  vim.command('Top', toggle(fterm.top))
  vim.command('Neofetch', toggle(fterm.neofetch))
end

function M.setup_gitsigns()
  require('gitsigns').setup {}
end

function M.setup_kommentary()
  local config = require('kommentary.config')

  vim.g.kommentary_create_default_mappings = false

  config.configure_language('rust', {
    single_line_comment_string = '//',
    multi_line_comment_strings = {'/*', '*/'},
    prefer_single_line_comments = true,
  })

  vim.api.nvim_set_keymap('n', '<Leader>c', '<Plug>kommentary_line_default', {})
  vim.api.nvim_set_keymap('x', '<Leader>c', '<Plug>kommentary_visual_default', {})
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
    },
  }
end

function M.setup_nvim_startup()
  require('nvim-startup').setup {
    startup_file = string.format('/tmp/nvim-startuptime-%s', os.getenv('USER')),
    message = function(time)
      local message = string.format('neovim started in %s ms', time)
      vim.notify.info(message, {
        title = 'nvim-startup',
      })
      return message
    end,
  }
end

function M.setup_nvim_tree()
  require('nvim-tree').setup {
    hijack_cursor = true,
    update_focused_file = {
      enable = true,
    },
    diagnostics = {
      enable = true,
    },
    view = {
      width = 40,
    },
  }
end

function M.setup_onedark()
  local onedark = require('onedarkpro')

  onedark.setup {
    styles = {
      functions = 'bold,italic',
      keywords = 'italic',
    },
    hlgroups = {
      Constant = { style = 'italic' },
    },
  }
end

function M.setup_presence()
  require('presence'):setup {}
end

function M.setup_rust_tools()
  require('rust-tools').setup {
    tools = {
      hover_with_actions = false,
      inlay_hints = {
        other_hints_prefix = '» ',
        highlight = 'NonText',
      },
    },

    server = {
      settings = {
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true,
          },
          checkOnSave = {
            command = 'clippy',
          },
        },
      },
    },
  }
end

function M.setup_shade()
  require('shade').setup {}
end

function M.setup_telescope()
  local function map(seq, fname)
    local cmd = string.format([[<cmd>lua require('telescope.builtin').%s()<cr>]], fname)
    vim.api.nvim_set_keymap('n', '<Leader>'..seq, cmd, {})
  end

  require('telescope').setup {}

  map('ff', 'find_files')
  map('fg', 'live_grep')
  map('fh', 'help_tags')
end

function M.setup_todo_comments()
  require('todo-comments').setup {}
end

function M.setup_treesitter()
  require('nvim-treesitter.configs').setup {
    ensure_installed = 'maintained',
    highlight = {
      enable = true,
    },
    playground = {
      enable = true,
    }
  }

  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
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
    mode = 'lsp_document_diagnostics',
    use_lsp_diagnostic_signs = true,
  }
end

function M.setup_vgit()
  local vgit = require('vgit')
  vgit.setup {
    hls = vgit.themes.monokai,
  }
end

function M.setup_which_key()
  require('which-key').setup {
    icons = {
      separator = '->',
    },
    window = {
      border = 'single',
    },
  }
end

return M
