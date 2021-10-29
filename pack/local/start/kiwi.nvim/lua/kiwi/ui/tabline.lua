return function()
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
end
