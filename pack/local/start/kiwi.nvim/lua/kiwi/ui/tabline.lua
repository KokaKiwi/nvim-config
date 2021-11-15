return function()
  local nkey = require('nkey')

  vim.opt.termguicolors = true

  require('bufferline').setup {
    options = {
      buffer_close_icon = '',
      diagnostics = 'nvim_lsp',
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'File explorer',
          highlight = 'Directory',
          text_align = 'center',
        },
        {
          filetype = 'Outline',
          text = 'Symbols',
          highlight = 'Directory',
          text_align = 'center',
        },
      },
    },
  }

  nkey.register {
    { '<C-', {
      { 'PageDown>',  nkey.Cmd 'BufferLineCycleNext', help = 'Go to next tab' },
      { 'PageUp>',    nkey.Cmd 'BufferLineCyclePrev', help = 'Go to previous tab' },
    } },
    { '<Leader>b', {
      { '<',    nkey.Cmd 'BufferLineMovePrev', help = 'Move tab left' },
      { '>',    nkey.Cmd 'BufferLineMoveNext', help = 'Move tab right' },
    }, help = '+buffers' },
  }
end
