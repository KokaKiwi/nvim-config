local M = {}

function M.setup_catppuccino()
  local catppuccino = require('catppuccino')
  -- local util = require('catppuccino.utils.util')

  local colorscheme = 'dark_catppuccino'
  local err, colors = require('catppuccino.api.colors').get_colors(colorscheme)
  if not err.status then
    error(string.format('Unknown colorscheme: %s', colorscheme))
  end

  catppuccino.setup {
    colorscheme = colorscheme,
    term_colors = true,
    styles = {
      functions = 'bold,italic',
      keywords = 'italic',
    },
    integrations = {
      lsp_trouble = true,
      gitsigns = true,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = true,
      },
      which_key = true,
      indent_blankline = {
        enabled = true,
      },
      dashboard = true,
      bufferline = true,
    },
  }

  colors.diff.add = colors.green

  catppuccino.remap(colors, {
    Constant = { fg = colors.orange, style = 'italic' },

    TSBoolean = { fg = colors.orange, style = 'italic' },
    TSConstBuiltin = { fg = colors.orange, style = 'italic' },

    diffAdded = { fg = colors.diff.add },
    diffRemoved = { fg = colors.diff.delete },
  })
end

function M.setup_onedark()
  local onedark = require('onedarkpro')

  onedark.setup {
    styles = {
      functions = 'bold,italic',
      keywords = 'italic',
    },
    hlgroups = {
      Constant = { style = 'italic' },
    },
  }
end

return M
