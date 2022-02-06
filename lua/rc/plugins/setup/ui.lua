local M = {}

function M.setup_comment_box()
  require('comment-box').setup {}
end

function M.setup_competitest()
  require('competitest').setup {}
end

function M.setup_cosmic()
  require('cosmic-ui').setup {}
end

function M.setup_devicons()
  local devicons = require('nvim-web-devicons')

  devicons.setup {
    default = true,
  }

  local icons = devicons.get_icons()

  local function copy(key, icon, name)
    local value = icons[key]
    if name ~= nil then
      value.name = name
    end
    value.icon = icon
    return value
  end

  local OVERRIDES = {
    ['.gitignore']      = u'E7A8',
    ['COMMIT_EDITMSG']  = u'E7A8',
    ['cjs']             = copy('js', u'E64E', 'CommonJS'),
    ['css']             = u'E649',
    ['ex']              = u'E997',
    ['exs']             = u'E997',
    ['hs']              = u'E95F',
    ['js']              = u'E64E',
    ['lua']             = u'E9A7',
    ['nix']             = u'E9B2',
    ['py']              = u'E63C',
    ['rs']              = u'E959',
    ['toml']            = u'E699',
    ['vim']             = u'E6C5',
    ['yaml']            = u'E699',
    ['yml']             = u'E699',
  }

  for key, icon in pairs(OVERRIDES) do
    if type(icon) == 'table' then
      icons[key] = icon
    else
      icons[key].icon = icon
    end
  end
end

function M.setup_dressing()
  require('dressing').setup {}
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
      cmd = 'btop',
      border = 'double',
      dimensions = {
        width = 0.9,
        height = 0.9,
      },
    },
    neofetch = FTerm:new {
      cmd = 'neofetch',
      auto_close = false,
      blend = 75,
      dimensions = {
        width = 0.5,
        height = 0.6,
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

function M.setup_lsp_signature()
  require('lsp_signature').setup {}
end

function M.setup_minimap()
  prefixed(vim.g, 'minimap') {
    block_filetypes = { 'NvimTree', 'Outline' },
    close_filetypes = { 'alpha', 'packer' },
  }
end

function M.setup_nnn()
  require('nnn').setup {}
end

function M.setup_notify()
  local notify = require('notify')

  notify.setup {
    stages = 'fade',
  }

  local function create_notifier(level)
    return function(msg, opts)
      return notify(msg, level, opts)
    end
  end
  vim.notify = {
    trace = create_notifier('trace'),
    debug = create_notifier('debug'),
    info = create_notifier('info'),
    warn = create_notifier('warn'),
    error = create_notifier('error'),
  }
  setmetatable(vim.notify, {
    __call = function(_, msg, level, opts)
      return notify(msg, level, opts)
    end,
  })
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
    git = {
      enable = false,
    },
    view = {
      width = 40,
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
  }

  local SPECIAL_FILES = {
    'README', 'README.md',
    'Makefile', 'Justfile',
    'LICENSE',
  }

  prefixed(vim.g, 'nvim_tree') {
    auto_ignore_ft = { 'startify', 'alpha' },
    ignore = {
      '.git', '.hg', '.svn', '.bzr', '.pijul',
      '.pyc', '.pyd', '.egg-infos', '__pycache__',
      '.class',
      '.swp',
    },
    special_files = table.dmap(SPECIAL_FILES, function(_, fname)
      return fname, 1
    end),
    quit_on_open = 1,
    show_icons = {
      git = 0,
      folders = 1,
      files = 1,
      folder_arrows = 1,
    },
    icons = {
      default = u'F18E',
      symlink = u'F19D',
      folder = {
        arrow_closed = u'F142',
        arrow_open = u'F13E',
        default = u'F07B',
        open = u'F07C',
        empty = u'F07B',
        empty_open = u'F07C',
        symlink = u'F19D',
        symlink_open = u'F07C',
      },
    },
    group_empty = 1,
    add_trailing = 1,
    disable_window_picker = 1,
  }
end

function M.setup_scrollbar()
  require('scrollbar').setup {
    excluded_filetypes = {
      '', 'prompt', 'TelescopePrompt',
      'alpha', 'NvimTree', 'packer',
    }
  }
end

function M.setup_symbols_outline()
  require('symbols-outline').setup {
    width = 40,
  }
end

function M.setup_telescope()
  require('telescope').setup {}
end

function M.setup_virt_column()
  require('virt-column').setup {}
end

return M
