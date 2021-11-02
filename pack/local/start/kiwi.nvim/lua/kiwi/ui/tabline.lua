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
          filetype = 'vista_kind',
          text = 'Symbols',
          highlight = 'Directory',
          text_align = 'center',
        },
      },
    },
  }

  nkey.register {
    { '<C-', {
      { 'PageDown>',  nkey.Cmd 'BufferLineCycleNext' },
      { 'PageUp>',    nkey.Cmd 'BufferLineCyclePrev' },
    } },
    { '<Leader>b', {
      { '<',    nkey.Cmd 'BufferLineMovePrev' },
      { '>',    nkey.Cmd 'BufferLineMoveNext' },
    } },
  }
end
