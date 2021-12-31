local M = {}

function M.setup_catppuccin()
  local catppuccin = require('catppuccin')
  local util = require('catppuccin.utils.util')

  local colors = require('catppuccin.api.colors').get_colors()
  if colors._base == nil then
    colors._base = table.copy(colors)
  end

  colors.catppuccin1 = util.darken(colors._base.black2, 0.7)

  catppuccin.setup {
    term_colors = true,
    transparent_background = false,
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
    Constant = { fg = colors.peach, style = 'italic' },

    TSBoolean = { fg = colors.peach, style = 'italic' },
    TSConstBuiltin = { fg = colors.peach, style = 'italic' },

    diffAdded = { fg = colors.teal },
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
