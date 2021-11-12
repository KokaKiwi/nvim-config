local M = {}

function M.setup_catppuccin()
  local catppuccin = require('catppuccin')
  local util = require('catppuccin.utils.util')

  local colors = require('catppuccin.api.colors').get_colors()
  local term_colors = false
  local transparent_background = false

  if colors._base == nil then
    colors._base = table.copy(colors)
  end
  colors.catppuccin1 = util.darken(colors._base.catppuccin1, 0.7)

  catppuccin.setup {
    term_colors = term_colors,
    transparent_background = transparent_background,
    transparency = transparent_background,
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

  catppuccin.remap {
    Constant = { fg = colors.catppuccin6, style = 'italic' },

    TSBoolean = { fg = colors.catppuccin6, style = 'italic' },
    TSConstBuiltin = { fg = colors.catppuccin6, style = 'italic' },

    diffAdded = { fg = colors.catppuccin7 },
  }
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
