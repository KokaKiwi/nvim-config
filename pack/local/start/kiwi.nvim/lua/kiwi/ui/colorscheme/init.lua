return function()
  local catppuccin = require('catppuccin')

  catppuccin.setup {
    term_colors = true,

    styles = {
      functions = { 'bold', 'italic' },
    },

    integrations = {
      lsp_trouble = true,
      which_key = true,
    },
  }
  catppuccin.load()
end
