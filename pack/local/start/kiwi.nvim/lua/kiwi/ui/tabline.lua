return function()
  local nest = require('nest')

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

  nest.applyKeymaps {
    { '<C-', {
      { 'PageDown>',  nest.Cmd 'BufferLineCycleNext' },
      { 'PageUp>',    nest.Cmd 'BufferLineCyclePrev' },
    } },
    { '<Leader>b', {
      { '<',    nest.Cmd 'BufferLineMovePrev' },
      { '>',    nest.Cmd 'BufferLineMoveNext' },
    } },
  }
end
