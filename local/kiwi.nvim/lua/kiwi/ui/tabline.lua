return function()
  local nkey = require('nkey')

  vim.opt.termguicolors = true

  require('bufferline').setup {
    options = {
      diagnostics = 'nvim_lsp',
      separator_style = 'slope',
      offsets = {
        {
          filetype = 'NvimTree',
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
    { '<C-', {
      { 'PageDown>',  nkey.Cmd 'BufferLineCycleNext', help = 'Go to next buffer' },
      { 'PageUp>',    nkey.Cmd 'BufferLineCyclePrev', help = 'Go to previous buffer' },
    }, help = '+buffers' },
    { '<Leader>b', {
      { '<',    nkey.Cmd 'BufferLineMovePrev', help = 'Move buffer left' },
      { '>',    nkey.Cmd 'BufferLineMoveNext', help = 'Move buffer right' },
    }, help = '+buffers' },
    { '<M-', {
      { 'PageDown>',  nkey.Cmd 'tabnext', help = 'Go to next tab' },
      { 'PageUp>',    nkey.Cmd 'tabprev', help = 'Go to previous tab' },
    }, help = '+tabs' }
  }
end
