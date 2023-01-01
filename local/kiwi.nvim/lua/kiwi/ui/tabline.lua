return function()
  local nkey = require('nkey')

  vim.opt.termguicolors = true

  require('bufferline').setup {
    options = {
      buffer_close_icon = '',
      diagnostics = 'nvim_lsp',
      custom_filter = function(bufnr, bufnrs)
        local current_tabpage = vim.api.nvim_get_current_tabpage()

        return true
      end,
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
