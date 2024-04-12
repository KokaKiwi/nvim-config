return function()
  local catppuccin = require('catppuccin')

  catppuccin.setup {
    flavour = 'mocha',
    term_colors = true,

    styles = {
      functions = { 'bold', 'italic' },
      keywords = { 'italic' },
    },

    integrations = {
      aerial = true,
      alpha = true,
      dap = {
        enabled = true,
        enable_ui = true,
      },
      dashboard = false,
      dropbar = {
        enabled = true,
      },
      fidget = true,
      gitsigns = true,
      indent_blankline = {
        enabled = true,
        scope_color = 'green',
        colored_indent_levels = true,
      },
      lsp_trouble = true,
      mason = true,
      navic = {
        enabled = true,
      },
      neotest = true,
      neotree = true,
      noice = true,
      notify = true,
      overseer = true,
      telescope = true,
      treesitter_context = true,
      which_key = true,
    },

    compile = {
      enabled = true,
    },
  }

  catppuccin.load()
end
