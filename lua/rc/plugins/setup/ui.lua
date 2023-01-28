local M = {}

function M.setup_aerial()
  require('aerial').setup {
    layout = {
      min_width = 30,
      max_width = 50,
    },
  }
end

function M.setup_ccc()
  local nkey = require('nkey')

  local ccc = require('ccc')

  ccc.setup {
    mappings = {
      ['l'] = ccc.mapping.decrease1,
      ['m'] = ccc.mapping.increase1,
      ['n'] = ccc.mapping.decrease10,
      [','] = ccc.mapping.increase10,
    },
  }

  nkey.register {
    { 'ccc', function()
        require('ccc.ui'):open(false)
      end,
      help = 'Pick color' },
  }
end

function M.setup_cellular_automaton()
end

function M.setup_colorful_winsep()
  require('colorful-winsep').setup {}
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

function M.setup_git_blame_virt()
  require('git-blame-virt').setup {
    ft = {
      cpp = false,
    }
  }
end

function M.setup_gitsigns()
  require('gitsigns').setup {}
end

function M.setup_hydra()
  local Hydra = require('hydra')
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

function M.setup_modicator()
  require('modicator').setup {
    show_warnings = false,
  }
end

function M.setup_nnn()
  require('nnn').setup {}
end

function M.setup_noice()
  require('noice').setup {
    cmdline = {
      view = 'cmdline',
      format = {
        cmdline = { icon = u'F16F' .. ' ' },
        search_down = { icon = u'F2A0' .. ' ' },
        search_up = { icon = u'F2A0' .. ' ' },
      },
    },
    lsp = {
      hover = { enabled = false },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
    },
    presets = {
      bottom_search = true,
    },
    commands = {
      messages = {
        view = 'popup',
        opts = { enter = true },
        filter = {
          any = {
            { event = 'notify' },
            { event = 'msg_show' },
          },
        },
      },
    },
  }
end

function M.setup_notify()
  local notify = require('notify')

  notify.setup {
    stages = 'fade',
  }
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
          default = u'F1B5',
          symlink = u'F1C9',
          folder = {
            arrow_closed = u'F14E',
            arrow_open = u'F149',
            default = u'F1C1',
            open = u'F1C3',
            empty = u'F1BF',
            empty_open = u'F1BF',
            symlink = u'F1C9',
            symlink_open = u'F1C9',
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
  local telescope = require('telescope')

  telescope.setup {}

  telescope.load_extension('aerial')
  telescope.load_extension('lazy')
  telescope.load_extension('noice')
  telescope.load_extension('notify')
end

function M.setup_virt_column()
  require('virt-column').setup {}
end

function M.setup_zone()
  require('zone').setup {}
end

return M
