local M = {}

function M.setup_catppuccin()
  local catppuccin = require('catppuccin')
  -- local util = require('catppuccino.utils.util')

  local colors = require('catppuccin.api.colors').get_colors()

  catppuccin.setup {
    -- term_colors = true,
    transparent_background = true,
    transparency = true,
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
