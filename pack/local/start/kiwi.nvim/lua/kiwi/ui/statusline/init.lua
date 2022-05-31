local components = require('kiwi.ui.statusline.components')
local providers = require('kiwi.ui.statusline.providers')

local function build_theme()
  local colors = require('catppuccin.api.colors').get_colors()

  return {
    bg        = '#1F1F23',
    black     = '#1B1B1B',
    skyblue   = '#50B0F0',
    cyan      = '#009090',
    fg        = '#D0D0D0',
    green     = '#60A040',
    oceanblue = '#0066cc',
    magenta   = '#C26BDB',
    orange    = '#FF9000',
    red       = '#D10000',
    violet    = '#9E93E8',
    white     = '#FFFFFF',
    yellow    = '#E1E120',
  }
end

local separators = {
  small_block = '▊',
  block       = '█',

  left         = '',
  right        = '',

  left_filled  = '',
  right_filled = '',

  slant_left         = '',
  slant_left_thin    = '',

  slant_right        = '',
  slant_right_thin   = '',

  slant_left_2       = '',
  slant_left_2_thin  = '',

  slant_right_2      = '',
  slant_right_2_thin = '',

  left_rounded       = '',
  left_rounded_thin  = '',

  right_rounded      = '',
  right_rounded_thin = '',

  circle = '●',
}

local function build_vi_mode_colors()
  local color = require('klib.util.colors')

  local colors = {
    insert = color.get_bg('ModesInsert', '#78ccc5'),
    visual = color.get_bg('ModesVisual', '#9745be'),
  }

  return {
    ['NORMAL']    = 'green',
    ['OP']        = 'green',
    ['INSERT']    = colors.insert,
    ['VISUAL']    = colors.visual,
    ['LINES']     = colors.visual,
    ['BLOCK']     = colors.visual,
    ['REPLACE']   = 'violet',
    ['V-REPLACE'] = 'violet',
    ['ENTER']     = 'cyan',
    ['MORE']      = 'cyan',
    ['SELECT']    = 'orange',
    ['COMMAND']   = 'green',
    ['SHELL']     = 'green',
    ['TERM']      = 'green',
    ['NONE']      = 'yellow',
  }
end

return function()
  require('feline').setup {
    components = components,
    custom_providers = providers,
    separators = separators,
    vi_mode_colors = build_vi_mode_colors(),
    theme = build_theme(),
    force_inactive = {
      filetypes = { '^help$' },
      buftypes = { '^terminal$' },
    },
    disable = {
      filetypes = { '^alpha$', '^NvimTree$', '^packer$', '^LspTrouble$' },
    },
  }
end
