local M = {}

function M.setup_Comment()
  require('Comment').setup {
    toggler = {
      line = '<Leader>cc',
      block = '<Leader>bc',
    },
    opleader = {
      line = '<Leader>c',
      block = '<Leader>b',
    },
  }

  require('nkey').register {
    { '<Leader>', {
      { 'b', {
        { 'c', help = 'Toggle comment (blockwise)' },
      }, help = 'comment' },
      { 'c', {
        { 'c', help = 'Toggle comment (linewise)' },
      }, help = 'comment' },
    }, mode = 'n' },

    { '<Leader>', {
      { 'c', help = 'Toggle comment (linewise)' },
      { 'b', help = 'Toggle comment (blockwise)' },
    }, mode = 'x' },

    -- Unmap default keymaps
    { 'gc', {
      { 'o', 'none' },
      { 'O', 'none' },
      { 'A', 'none' },
    }, mode = 'n' },
  }
end

function M.setup_fcitx5()
  require('fcitx5').setup {}
end

function M.setup_gomove()
  require('gomove').setup {}
end

function M.setup_keep_it_secret()
  local keep_it_secret = require('keep-it-secret')

  keep_it_secret.setup {}

  require('nkey').register {
    { '<Leader>Ks', function()
        keep_it_secret.toggle()
      end,
      help = 'Keep it Secret',
    },
  }
end

function M.setup_kitty_runner()
  require('kitty-runner').setup {}
end

function M.setup_neorg()
  require('neorg').setup {
    load = {
      ['core.defaults'] = {},
      ['core.keybinds'] = {
        config = {
          default_keybinds = true,
          neorg_leader = '<Leader>o',
        },
      },
      ['core.norg.concealer'] = {},
      ['core.norg.dirman'] = {},
      ['core.norg.completion'] = {
        config = {
          engine = 'nvim-cmp',
        },
      },
    },
  }
end

function M.setup_silicon()
  require('silicon').setup({
      _ = 'dummy',
    })
end

function M.setup_sort()
  require('sort').setup {
    debug = false,
  }
end

function M.setup_viewdoc()
  require('viewdoc').setup {}
end

return M
