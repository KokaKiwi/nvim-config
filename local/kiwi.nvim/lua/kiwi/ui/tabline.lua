return function()
  local bufferline = require('bufferline')
  local nkey = require('nkey')

  vim.o.termguicolors = true

  bufferline.setup {
    highlights = require("catppuccin.groups.integrations.bufferline").get(),
    options = {
      diagnostics = 'nvim_lsp',
      separator_style = 'slope',
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'File explorer',
          highlight = 'Directory',
          text_align = 'center',
        },
        {
          filetype = 'aerial',
          text = 'Symbols',
          highlight = 'Directory',
          text_align = 'center',
        },
      },
    },
  }

  nkey.register {
    -- Buffers ops
    { '<C-', {
      { 'PageDown>',  nkey.Call(bufferline.cycle, 1), help = 'Go to next buffer' },
      { 'PageUp>',    nkey.Call(bufferline.cycle, -1), help = 'Go to previous buffer' },
    }, help = '+buffers' },
    { '<Leader>b', {
      { '<',    nkey.Call(bufferline.move, -1), help = 'Move buffer left' },
      { '>',    nkey.Call(bufferline.move, 1), help = 'Move buffer right' },
    }, help = '+buffers' },

    -- Tabs ops
    { '<Leader>T', nkey.Cmd '$tabnew', help = 'Create tab page' },
    { '<M-', {
      { 'PageDown>',  nkey.Cmd 'tabnext', help = 'Go to next tab' },
      { 'PageUp>',    nkey.Cmd 'tabprev', help = 'Go to previous tab' },
    }, help = '+tabs' }
  }
end
