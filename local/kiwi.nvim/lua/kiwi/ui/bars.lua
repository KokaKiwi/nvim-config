local color = require('klib.util.colors')

local nougat = lazy.Lazy(function()
  return {
    core = require('nougat.core'),
    bar_util = require('nougat.bar.util'),
    sep = require('nougat.separator'),

    nut = {
      buf = {
        diagnostic_count = require('nougat.nut.buf.diagnostic_count').create,
        fileencoding = require('nougat.nut.buf.fileencoding').create,
        filename = require('nougat.nut.buf.filename').create,
        filestatus = require('nougat.nut.buf.filestatus').create,
        filetype = require('nougat.nut.buf.filetype').create,
      },
      git = {
        branch = require('nougat.nut.git.branch').create,
        status = require('nougat.nut.git.status'),
      },
      mode = require('nougat.nut.mode').create,
      ruler = require('nougat.nut.ruler').create,
      spacer = require('nougat.nut.spacer').create,
      truncation_point = require('nougat.nut.truncation_point').create,
    },

    Bar = require('nougat.bar'),
    Item = require('nougat.item'),
  }
end)

local cat = lazy.Lazy(function()
  return require('catppuccin.palettes').get_palette()
end, true)

local components = lazy.Lazy(function()
  local mode_colors = {
    normal = color.get_bg('ModesNormal', cat.green),
    visual = color.get_bg('ModesVisual', '#9745be'),
    insert = color.get_bg('ModesInsert', '#78ccc5'),
    replace = color.get_bg('ModesReplace', cat.violet),
  }

  return {
    mode = nougat.nut.mode {
      prefix = ' ',
      suffix = ' ',
      sep_right = nougat.sep.right_lower_triangle_solid(true),
      config = {
        highlight = {
          normal = {
            bg = mode_colors.normal,
            bold = true,
          },
          visual = {
            bg = mode_colors.visual,
            bold = true,
          },
          insert = {
            bg = mode_colors.insert,
            bold = true,
          },
          replace = {
            bg = mode_colors.replace,
            bold = true,
          },
          inactive = {},
        },
      },
    },
    lazy = nougat.Item {
      content = function()
        return require('lazy.status').updates()
      end,
      hidden = function()
        return not require('lazy.status').has_updates()
      end,
      prefix = ' ', suffix = ' ',
      hl = {
        fg = cat.crust,
        bg = cat.mauve,
        bold = true,
      },
      sep_left = nougat.sep.left_upper_triangle_solid(true),
      sep_right = nougat.sep.right_upper_triangle_solid(true),
    },
    lsp = {
      client_names = nougat.Item {
        content = function(item, ctx)
          local clients = {}

          for _, client in pairs(vim.lsp.get_clients { bufnr = ctx.bufnr }) do
            table.insert(clients, client.name)
          end

          return table.concat(clients, ' ')
        end,
        hidden = function(item, ctx)
          return #vim.lsp.get_clients({ bufnr = ctx.bufnr }) == 0
        end,
        prefix = ' ',
        suffix = ' ',
        sep_right = nougat.sep.right_lower_triangle_solid(true),
        hl = {
          fg = cat.crust,
          bg = cat.rosewater,
          bold = true,
        },
      },
      navic = nougat.Item {
        hidden = function(_, ctx)
          local has_navic, navic = pcall(require, 'nvim-navic')
          return has_navic and not navic.is_available(ctx.bufnr)
        end,
        prefix = ' ',
        content = function(_, ctx)
          return require('nvim-navic').get_location({
            highlight = true,
            click = true,
          }, ctx.bufnr)
        end,
      },
    },
    buf = {
      filestatus = nougat.Item {
        prefix = ' ', suffix = ' ',
        hl = {
          bg = cat.green,
          fg = cat.crust,
          bold = true,
        },
        sep_left = nougat.sep.left_half_circle_solid(true),
        sep_right = nougat.sep.right_half_circle_solid(true),
        content = {
          nougat.nut.buf.filename {
            config = {
              modifier = ':t',
            },
          },
          nougat.nut.buf.filestatus {
            config = {
              modified = '*',
              nomodifiable = '',
              readonly = ' [RO]',
              sep = ' ',
            },
          }
        },
      },
      filepos = nougat.Item {
        hl = { bold = true },
        content = {
          nougat.nut.buf.filetype {
            prefix = ' ', suffix = ' ',
            sep_left = nougat.sep.left_lower_triangle_solid(true),
            hl = {
              bg = cat.surface0,
            },
          },
          nougat.Item {
            content = nougat.core.group {
              nougat.core.code('l'),
              ':',
              nougat.core.code('c'),
            },
            sep_left = nougat.sep.left_lower_triangle_solid(true),
            hl = {
              bg = cat.surface1,
            },
            prefix = ' ', suffix = ' ',
          },
          nougat.Item {
            hl = {
              bg = cat.blue,
              fg = cat.base,
            },
            prefix = ' ', suffix = ' ',
            content = nougat.core.code('P'),
            sep_left = nougat.sep.left_lower_triangle_solid(true),
          },
        },
      },
    },
  }
end)

local function make_statusline()
  local statusline = nougat.Bar('statusline')

  -- Left
  statusline:add_item(components.mode)
  statusline:add_item(components.lsp.client_names)

  statusline:add_item(nougat.nut.spacer())

  -- Middle
  statusline:add_item(components.buf.filestatus)

  statusline:add_item(nougat.nut.spacer())

  -- Right
  statusline:add_item(components.lazy)
  statusline:add_item(' ')
  statusline:add_item(components.buf.filepos)

  return statusline
end

local function make_inactive_statusline()
  local statusline = nougat.Bar('statusline')

  -- Left
  statusline:add_item(components.mode)

  statusline:add_item(nougat.nut.spacer())

  -- Right

  return statusline
end

local function make_winbar()
  local winbar = nougat.Bar('winbar')

  winbar:add_item(components.lsp.navic)

  return winbar
end

local CONFIG = {
  force_inactive = {
    filetypes = { 'help' },
    buftypes = {},
  },
  disable = {
    filetypes = {},
    buftypes = { 'terminal', 'nofile' },
  },
}

return function()
  local empty_statusline = nougat.Bar('statusline')

  local statusline = make_statusline()
  local inactive_statusline = make_inactive_statusline()

  local winbar = make_winbar()

  nougat.bar_util.set_statusline(function(ctx)
    local filetype = vim.bo[ctx.bufnr].filetype
    local buftype = vim.bo[ctx.bufnr].buftype

    local disable = table.contains(CONFIG.disable.filetypes, filetype) or
      table.contains(CONFIG.disable.buftypes, buftype)
    if disable then
      return empty_statusline
    end

    local force_inactive = table.contains(CONFIG.force_inactive.filetypes, filetype) or
      table.contains(CONFIG.force_inactive.buftypes, buftype)
    if ctx.is_focused and not force_inactive then
      return statusline
    else
      return inactive_statusline
    end
  end)

  nougat.bar_util.set_winbar(winbar)
end
