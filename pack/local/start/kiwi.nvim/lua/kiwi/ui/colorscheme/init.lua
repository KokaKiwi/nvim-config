local THEMES = {
  'ayu',
  'ayu_dark',
  'ayu_mirage',
  'catppuccin',
  'darknight',
  'doom_one',
  'dracula',
  'everforest',
  'gruvbox',
  'javacafe',
  'kanagawa',
  'kurai',
  'monokai',
  'monokai_pro',
  'nord',
  'onedark',
  'papa_dark',
  'rose_pine',
  'rose_pine_dawn',
  'rose_pine_moon',
  'shado',
  'tokyodark',
  'tokyonight',
}

local INTEGRATIONS = {
  'dashboard',
  'nvim_tree',
  'which_key',
}

local COLORSCHEMES = {
  'catppuccin',
}
local LANGS = {}

local function extends_palette(cp)
  return {
    hidden = { fg = cp.bg.base, bg = cp.bg.base },
    syntax = {
      mark = cp.dimmed.subtle,
    },
  }
end

return function()
  local themer = require('themer')

  themer.setup {
    colorscheme = 'catppuccin',
    styles = {
      ['function'] = { style = 'bold,italic' },
      keyword = { style = 'italic' },
    },
    remaps = {
      palette = table.djoin(
        {
          globals = extends_palette,
        },
        table.map(COLORSCHEMES, function(name)
          local remap = require('kiwi.ui.colorscheme.colorschemes.' .. name)
          if remap.palette == nil then
            return nil
          end

          return name, remap.palette
        end, true)
      ),
      highlights = table.djoin(
        {
          globals = function(cp)
            return {
              plugins = table.map(INTEGRATIONS, function(name)
                local integration = require('kiwi.ui.colorscheme.integrations.' .. name)
                return name, integration(cp)
              end, true),
              langs = table.map(LANGS, function(name)
                local integration = require('kiwi.ui.colorscheme.langs.' .. name)
                return name, integration(cp)
              end, true),
            }
          end,
        },
        table.map(COLORSCHEMES, function(name)
          local remap = require('kiwi.ui.colorscheme.colorschemes.' .. name)
          if remap.highlights == nil then
            return nil
          end

          return name, remap.highlights
        end, true)
      ),
    },
  }

  vim.command('Theme', function(colorscheme)
    themer.setup { colorscheme = colorscheme }
  end, { nargs = 1, complete = THEMES })
end
