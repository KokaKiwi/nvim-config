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
      fidget = true,
      gitsigns = true,
      headlines = true,
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
      snacks = {
        enabled = true,
        indent_scope_color = 'lavender',
      },
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
