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

    compile = {
      enabled = true,
    },
  }

  vim.g.catppuccin_flavour = 'mocha'
  catppuccin.load()
end
