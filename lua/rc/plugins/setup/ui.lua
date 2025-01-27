local M = {}

function M.setup_aerial()
  require('aerial').setup {
    layout = {
      min_width = 30,
      max_width = 50,
    },
  }
end

function M.setup_blankline()
  local highlight = {
    'RainbowRed',
    'RainbowYellow',
    'RainbowBlue',
    'RainbowOrange',
    'RainbowGreen',
    "RainbowViolet",
    'RainbowCyan',
  }

  require('ibl').setup {
    exclude = {
      buftypes = { 'terminal', 'alpha', 'help', 'lazy' },
    },
    indent = {
      highlight = highlight,
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

function M.setup_colorful_menu()
  require('colorful-menu').setup {}
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

function M.setup_deadcolumn()
  require('deadcolumn').setup {}
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
  }

  for key, icon in pairs(OVERRIDES) do
    if icons[key] == nil then
      icons[key] = {
        name = key,
      }
    end
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

function M.setup_fidget()
  require('fidget').setup {
    notification = {
      override_vim_notify = true,
      window = {
        winblend = 0,
      },
    },
    integration = {
      ['nvim-tree'] = { enable = false },
      ['xcodebuild-nvim'] = { enable = false },
    },
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

function M.setup_image()
  require('image').setup {
    backend = 'kitty',
  }
end

function M.setup_lsp_lens()
  require('lsp-lens').setup {}
end

function M.setup_lsp_ui()
  local nkey = require('nkey')
  local lspui = require('LspUI')

  -- Fixup
  lspui.api.rename = require('LspUI.modules').rename.run

  lspui.setup {
    lightbulb = {
      enable = false,
    },
  }

  nkey.register {
    { 'g', {
      { 'a', lspui.api.code_action, help = 'Show Code Actions [LSP]' },
      { 'A', function() lspui.api.diagnostic('next') end, help = 'Show next diagnostic [LSP]' },
      { 'R', lspui.api.rename, help = 'Rename symbol [LSP]' },
    } },
  }
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

function M.setup_navigator()
  local nkey = require('nkey')

  require('navigator').setup {
    debug = true,
    mason = true,
    lsp = {
      disable_lsp = 'all',
      format_on_save = false,
      diagnostic_scrollbar_sign = false,
      display_diagnostic_qf = false,
      diagnostic = {
        enable = false,
      },
    },
  }

  nkey.register {
    { '<Leader>', {
      { 'ca', require('navigator.codeAction').code_action, help = 'Code Action [LSP]' },
      { 'ca', require('navigator.codeAction').range_code_action, help = 'Code Action [LSP]', mode = 'v' },
    } },
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
          '.env',
          '.envrc',
          '.rtx.toml',
          '.tool-versions',
        },
      },
      window = {
        mappings = {
          ['o'] = 'system_open',
          ['d'] = 'trash',
          ['D'] = 'delete',
        },
      },
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()

          vim.fn.system({ 'xdg-open', path })
        end,
        trash = function(state)
          local ui_inputs = require('neo-tree.ui.inputs')
          local manager = require('neo-tree.sources.manager')

          local node = state.tree:get_node()
          local path = node:get_id()

          local msg = string.format('Are you sure you want to delete `%s', path)
          ui_inputs.confirm(msg, function(res)
            if not res then
              return
            end

            vim.fn.system({ 'trash', vim.fn.fnameescape(path) })
            manager.refresh(state.name)
          end)
        end,
      },
      follow_current_file = {
        enabled = true,
      },
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

function M.setup_nnn()
  require('nnn').setup {}
end

function M.setup_noice()
  require('noice').setup {
    cmdline = {
      view = 'cmdline',
    },
    messages = {
      enabled = false,
    },
    notify = {
      enabled = false,
    },
    lsp = {
      progress = { enabled = false },
      hover = { enabled = false },
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
    },
    presets = {
      bottom_search = true,
    },
    format = {
      spinner = {
        name = 'dots13',
      },
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
  require('notify').setup {
    stages = 'fade',
    background_colour = '#000000',
  }
end

function M.setup_pets()
  require('pets').setup {}
end

function M.setup_relative_toggle()
  require('relative-toggle').setup {}
end

function M.setup_scope()
  require('scope').setup()
end

function M.setup_scrollview()
  require('scrollview').setup {
    always_show = true,
    current_only = true,
    excluded_filetypes = {
      'prompt', 'TelescopePrompt',
      'alpha', 'neo-tree', 'lazy',
    },
  }
end

function M.setup_sentiment()
  require('sentiment').setup {}
end

function M.setup_telescope()
  local telescope = require('telescope')

  telescope.setup {}

  telescope.load_extension('aerial')
  telescope.load_extension('lazy')
  telescope.load_extension('media_files')
  telescope.load_extension('noice')
  telescope.load_extension('notify')
  telescope.load_extension('persisted')
  telescope.load_extension('scope')
end

function M.setup_treesitter_context()
  require('treesitter-context').setup {
    max_lines = 5,
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

function M.setup_vfiler()
  require('vfiler/config').setup {
    options = {
      columns = 'indent,devicons,name,mode,size,time',
    },
  }
end

function M.setup_zone()
  require('zone').setup {}
end

return M
