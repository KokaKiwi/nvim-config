local M = {}

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

  prefixed(vim.g, 'nvim_tree') {
    auto_ignore_ft = { 'startify' },
    ignore = {
      '.git', '.hg', '.svn', '.bzr', '.pijul',
      '.pyc', '.pyd', '.egg-infos', '__pycache__',
      '.class',
      '.swp',
    },
    special_files = {
      ['README.md'] = 1,
      ['Makefile'] = 1,
      ['Justfile'] = 1,
    },
    quit_on_open = 1,
    show_icons = {
      git = 0,
      folders = 1,
      files = 1,
      folder_arrows = 1,
    },
    icons = {
      default = '',
      symlink = '',
      folder = {
        arrow_open = '',
        arrow_closed = '',
        default = '',
        open = '',
        empty = '',
        empty_open = '',
        symlink = '',
        symlink_open = '',
      },
    },
    group_empty = 1,
    add_trailing = 1,
    disable_window_picker = 1,
  }
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

return M
