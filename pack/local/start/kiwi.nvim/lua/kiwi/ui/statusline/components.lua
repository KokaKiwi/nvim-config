local kcolors = require('klib.util.colors')
local lazy = require('klib.util.lazy')

local cat = lazy.dict(function()
  return require('catppuccin.palettes').get_palette()
end, false)
local vi_mode = lazy.require('feline.providers.vi_mode')

local colors = lazy.dict(function()
  return {
    lsp = cat.rosewater,
    file_info = cat.green,
    file_meta = cat.peach,
    position = cat.teal,
  }
end, false)

return {
  active = {
    -- Left
    {
      {
        provider = 'empty',
        left_sep = {
          str = 'small_block',
          hl = function()
            return {
              fg = kcolors.lighten(vi_mode.get_mode_color(), 0.4),
            }
          end,
        },
        update = { 'ModeChanged' },
      },
      -- ViM Mode
      {
        provider = {
          name = 'vi_mode',
          opts = {
            show_mode_name = true,
            padding = 'center',
          },
        },
        hl = function()
          return {
            name = vi_mode.get_mode_highlight_name(),
            fg = vi_mode.get_mode_color(),
            style = 'bold',
          }
        end,
        icon = string.format('%s ', u'EBF3'),
        right_sep = { ' ' },
        update = { 'ModeChanged' },
      },
      -- LSP
      {
        provider = 'lsp_client_names',
        icon = string.format('%s ', u'F085'),
        hl = {
          fg = cat.crust,
          bg = colors.lsp,
        },
        left_sep = {
          'slant_left',
          { str = ' ', hl = { bg = colors.lsp, fg = 'NONE' } },
        },
      },
      {
        provider = 'lsp_status',
        hl = {
          fg = cat.crust,
          bg = colors.lsp,
        },
        right_sep = {
          { str = ' ', hl = { bg = colors.lsp, fg = 'NONE' } },
          'slant_right',
        }
      },
      {
        provider = 'empty',
      },
    },
    -- Middle
    {
      {
        provider = {
          name = 'file_info',
          opts = {
            type = 'unique',
          },
        },
        hl = function()
          return {
            fg = cat.crust,
            bg = colors.file_info,
            style = 'bold',
          }
        end,
        left_sep = {
          'slant_left_2',
          { str = ' ', hl = { bg = colors.file_info, fg = 'NONE' } },
        },
        right_sep = {
          { str = ' ', hl = { bg = colors.file_info, fg = 'NONE' } },
          'slant_right_2',
          ' ',
        },
      },
    },
    -- Right
    {
      -- File meta
      {
        provider = {
          name = 'file_type',
          opts = {
            filetype_icon = true,
          },
        },
        hl = {
          fg = cat.crust,
          bg = colors.file_meta,
        },
        left_sep = {
          'slant_left',
          { str = ' ', hl = { bg = colors.file_meta, fg = 'NONE' } },
        },
        right_sep = {
          { str = ' ', hl = { bg = colors.file_meta, fg = 'NONE' } },
        },
      },
      {
        provider = 'file_size',
        hl = {
          fg = cat.crust,
          bg = colors.file_meta,
        },
        left_sep = {
          { str = 'slant_left_thin', hl = { bg = colors.file_meta, fg = cat.crust } },
          { str = ' ', hl = { bg = colors.file_meta, fg = 'NONE' } },
        },
        right_sep = {
          { str = ' ', hl = { bg = colors.file_meta, fg = 'NONE' } },
        },
      },
      {
        provider = 'file_encoding',
        hl = {
          fg = cat.crust,
          bg = colors.file_meta,
        },
        left_sep = {
          { str = 'slant_left_thin', hl = { bg = colors.file_meta, fg = cat.crust } },
          { str = ' ', hl = { bg = colors.file_meta, fg = 'NONE' } },
        },
        right_sep = {
          { str = ' ', hl = { bg = colors.file_meta, fg = 'NONE' } },
          { str = 'slant_left', hl = { bg = colors.file_meta, fg = cat.teal } },
        },
      },
      -- Position
      {
        provider = 'line_percentage',
        hl = {
          fg = cat.crust,
          bg = colors.position,
        },
        left_sep = {
          { str = ' ', hl = { bg = colors.position, fg = 'NONE' } },
        },
        right_sep = {
          { str = ' ', hl = { bg = colors.position, fg = 'NONE' } },
        },
      },
      {
        provider = {
          name = 'position',
          opts = { padding = true },
        },
        hl = {
          fg = cat.crust,
          bg = colors.position,
        },
        left_sep = {
          { str = 'slant_left_thin', hl = { bg = colors.position, fg = cat.crust } },
          { str = ' ', hl = { bg = colors.position, fg = 'NONE' } },
        },
        right_sep = {
          { str = ' ', hl = { bg = colors.position, fg = 'NONE' } },
        },
      },
    },
  },
  inactive = {
    -- Left
    {
      {
        provider = {
          name = 'file_info',
          opts = {
            type = 'unique',
          },
        },
        hl = function()
          return {
            fg = cat.crust,
            bg = colors.file_info,
            style = 'bold',
          }
        end,
        left_sep = {
          { str = ' ', hl = { bg = colors.file_info, fg = 'NONE' } },
        },
        right_sep = {
          { str = ' ', hl = { bg = colors.file_info, fg = 'NONE' } },
          'slant_right_2',
          ' ',
        },
      },
    },
    -- Right
    {},
  }
}
