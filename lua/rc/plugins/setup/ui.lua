local M = {}

function M.setup_aerial()
  require('aerial').setup {
    min_width = 30,
    max_width = 50,
  }
end

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

function M.setup_minimap()
  prefixed(vim.g, 'minimap') {
    block_filetypes = { 'NvimTree', 'aerial' },
    close_filetypes = { 'alpha', 'packer' },
  }
end

function M.setup_modes()
  require('modes').setup {
    line_opacity = 0.25,
    ignore_filetypes = { 'NvimTree', 'TelescopePrompt', 'aerial', 'packer' },
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
    ignore_ft_on_setup = { 'alpha' },
    update_focused_file = {
      enable = true,
    },
    diagnostics = {
      enable = true,
    },
    filters = {
      custom = {
        '^\\.git$', '^\\.hg$', '^\\.svn$', '^\\.bzr$', '^\\.pijul$',
        '\\.pyc$', '\\.pyd$', '\\.egg-info', '^__pycache__$',
        '\\.class$',
        '\\.swp$',
      },
    },
    git = {
      enable = false,
    },
    view = {
      width = 40,
      mappings = {
        list = {
          { key = '<C-e>', action = 'close' },
        },
      },
      hide_root_folder = false,
    },
    renderer = {
      add_trailing = true,
      group_empty = true,
      icons = {
        show = {
          git = false,
          folder = true,
          file = true,
          folder_arrow = true,
        },
        glyphs = {
          default = u'F1A4',
          symlink = u'F1B8',
          folder = {
            arrow_closed = u'F144',
            arrow_open = u'F140',
            default = u'F1B0',
            open = u'F1B0',
            empty = u'F1AE',
            empty_open = u'F1AE',
            symlink = u'F1B4',
            symlink_open = u'F1B4',
          },
        },
      },
      special_files = {
        'README', 'README.md',
        'Makefile', 'Justfile',
        'LICENSE',
      },
    },
    actions = {
      open_file = {
        quit_on_open = true,
        window_picker = {
          enable = false,
        },
      },
    },
  }
end

function M.setup_satellite()
  require('satellite').setup {
    excluded_filetypes = {
      '', 'prompt', 'TelescopePrompt',
      'alpha', 'NvimTree', 'packer',
    },
  }
end

function M.setup_telescope()
  require('telescope').setup {}

  require('telescope').load_extension('aerial')
  require('telescope').load_extension('gradle')
  require('telescope').load_extension('notify')
end

function M.setup_virt_column()
  require('virt-column').setup {}
end

return M
