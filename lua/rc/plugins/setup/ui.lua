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
      help = 'Pick color',
    },
  }
end

function M.setup_cellular_automaton()
end

function M.setup_colorful_winsep()
  require('colorful-winsep').setup {
    no_exec_files = { "lazy", "TelescopePrompt", "mason", "neo-tree" },
  }
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

function M.setup_hologram()
  require('hologram').setup {}
end

function M.setup_hydra()
  local Hydra = require('hydra')
end

function M.setup_minimap()
  prefixed(vim.g, 'minimap') {
    block_filetypes = { 'neo-tree', 'aerial' },
    close_filetypes = { 'alpha', 'lazy' },
  }
end

function M.setup_modes()
  require('modes').setup {
    line_opacity = 0.25,
    ignore_filetypes = { 'neo-tree', 'TelescopePrompt', 'aerial', 'lazy' },
  }
end

function M.setup_modicator()
  require('modicator').setup {
    show_warnings = false,
  }
end

function M.setup_neo_tree()
  vim.g.neo_tree_remove_legacy_commands = true

  require('neo-tree').setup {
    sources = {
      'filesystem',
      'buffers',
      'git_status',
      'netman.ui.neo-tree',
    },
    default_component_configs = {
      name = {
        trailing_slash = true,
      },
    },
    window = {
      mappings = {},
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        always_show = {
          '.gitignore',
          '.justfile',
        },
      },
      window = {
        mappings = {
          ['o'] = 'system_open',
        },
      },
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()

          vim.fn.system({ 'xdg-open', path })
        end,
      },
      follow_current_file = true,
      group_empty_dirs = true,
      use_libuv_file_watcher = true,
    },
    event_handlers = {
      {
        event = 'file_opened',
        handler = function()
          require('neo-tree.command').execute {
            action = 'close',
          }
        end,
      },
    },
  }
end

function M.setup_nkey()
  require('nkey').setup {
    integrations = {
      'legendary',
      'which_key',
    },
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

function M.setup_pets()
  require('pets').setup {}
end

function M.setup_satellite()
  require('satellite').setup {
    excluded_filetypes = {
      '', 'prompt', 'TelescopePrompt',
      'alpha', 'neo-tree', 'lazy',
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
