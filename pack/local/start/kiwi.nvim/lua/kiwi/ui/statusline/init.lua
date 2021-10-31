local function highlight(group, fg, bg, gui)
  local opts = {
    guifg = fg,
    guibg = bg,
  }
  if gui ~= nil then
    opts.gui = gui
  end

  vim.hi(group, opts)
end

local lineLengthWarning = 100
local lineLengthError   = 120
local leftbracket       = u'e0b2' -- Angle filled.
local rightbracket      = u'e0b0' -- Angle filled.

local colors = {
  bg              = '#333333',
  modetext        = '#000000',

  giticon         = '#FF8800',
  gitbg           = '#5C2C2E',
  gittext         = '#C5C5C5',

  diagerror       = '#F44747',
  diagwarn        = '#FF8800',
  diaghint        = '#4FC1FF',
  diaginfo        = '#FFCC66',

  lspicon         = '#68AF00',
  lspbg           = '#304B2E',
  lsptext         = '#C5C5C5',

  typeicon        = '#FF8800',
  typebg          = '#5C2C2E',
  typetext        = '#C5C5C5',

  statsicon       = '#9CDCFE',
  statsbg         = '#5080A0',
  statstext       = '#000000',

  lineokfg        = '#000000',
  lineokbg        = '#5080A0',
  linelongerrorfg = '#FF0000',
  linelongwarnfg  = '#FFFF00',
  linelongbg      = '#5080A0',

  shortbg         = '#DCDCAA',
  shorttext       = '#000000',

  shortrightbg    = '#3F3F3F',
  shortrighttext  = '#7C4C4E',

  red             = '#D16969',
  yellow          = '#DCDCAA',
  magenta         = '#D16D9E',
  green           = '#608B4E',
  orange          = '#FF8800',
  purple          = '#C586C0',
  blue            = '#569CD6',
  cyan            = '#4EC9B0'
}

local mode_map = {
  ['n']         = {'#569CD6', 'NORMAL'},
  ['i']         = {'#D16969', 'INSERT'},
  ['R']         = {'#D16969', 'REPLACE'},
  ['c']         = {'#608B4E', 'COMMAND'},
  ['v']         = {'#C586C0', 'VISUAL'},
  ['V']         = {'#C586C0', 'VIS-LN'},
  [22]          = {'#C586C0', 'VIS-BLK'},
  ['s']         = {'#FF8800', 'SELECT'},
  ['S']         = {'#FF8800', 'SEL-LN'},
  ['^S']        = {'#FF8800', 'SEL-BLK'},
  ['t']         = {'#569CD6', 'TERMINAL'},
  ['Rv']        = {'#D16D69', 'VIR-REP'},
  ['rm']        = {'#FF0000', '- More -'},
  ['r']         = {'#FF0000', "- Hit-Enter -"},
  ['r?']        = {'#FF0000', "- Confirm -"},
  ['cv']        = {'#569CD6', "Vim Ex Mode"},
  ['ce']        = {'#569CD6', "Normal Ex Mode"},
  ['!']         = {'#569CD6', "Shell Running"},
  ['ic']        = {'#DCDCAA', 'Insert mode completion |compl-generic|'},
  ['no']        = {'#DCDCAA', 'Operator-pending'},
  ['nov']       = {'#DCDCAA', 'Operator-pending (forced charwise |o_v|)'},
  ['noV']       = {'#DCDCAA', 'Operator-pending (forced linewise |o_V|)'},
  ['noCTRL-V']  = {'#DCDCAA', 'Operator-pending (forced blockwise |o_CTRL-V|) CTRL-V is one character'},
  ['niI']       = {'#DCDCAA', 'Normal using |i_CTRL-O| in |Insert-mode|'},
  ['niR']       = {'#DCDCAA', 'Normal using |i_CTRL-O| in |Replace-mode|'},
  ['niV']       = {'#DCDCAA', 'Normal using |i_CTRL-O| in |Virtual-Replace-mode|'},
  ['ix']        = {'#DCDCAA', 'Insert mode |i_CTRL-X| completion'},
  ['Rc']        = {'#DCDCAA', 'Replace mode completion |compl-generic|'},
  ['Rx']        = {'#DCDCAA', 'Replace mode |i_CTRL-X| completion'},
}

local function get_mode(mode)
  if mode == nil then
    mode = vim.fn.mode(1)
  end
  if mode_map[mode] == nil then
    mode = mode:byte()
  end
  if mode_map[mode] == nil then
    mode = 'n'
  end
  return mode_map[mode]
end

-- See: https://www.nerdfonts.com/cheat-sheet
local icons = {
  vim   = u'E6C5',
  dos   = u'E70F',
  unix  = u'F11A',
  mac   = u'F102',
}

local function setLineWidthColours()
  local colbg = colors.statsbg
  local linebg = colors.statsbg

  if (vim.fn.col('.') > lineLengthError)
    then
    colbg = colors.linelongerrorfg
  elseif (vim.fn.col('.') > lineLengthWarning)
    then
    colbg = colors.linelongwarnfg
  end

  if (vim.fn.strwidth(vim.fn.getline('.')) > lineLengthError)
    then
    linebg = colors.linelongerrorfg
  elseif (vim.fn.strwidth(vim.fn.getline('.')) > lineLengthWarning)
    then
    linebg = colors.linelongwarnfg
  end

  highlight('LinePosHighlightStart', colbg, colors.statsbg)
  highlight('LinePosHighlightColNum', colors.statstext, colbg)
  highlight('LinePosHighlightMid', linebg, colbg)
  highlight('LineLenHighlightLenNum', colors.statstext, linebg)
  highlight('LinePosHighlightEnd', linebg, colors.statsbg)
end

return function()
  local gl = require('galaxyline')
  local gls = gl.section

  local condition = require('galaxyline.condition')
  local providers = require('kiwi.ui.statusline.providers')

  gl.short_line_list = { 'NvimTree', 'packer', 'vista_kind', 'alpha' }

  -- Left
  gls.left = {}

  -- Edit mode
  table.extends(gls.left) {
    {
      ViModeSpaceOnFarLeft = {
        provider = providers.space(),
        highlight = { colors.giticon, colors.bg },
      }
    },
    {
      ViModeLeft = {
        provider = function()
          highlight('ViModeHighlight', get_mode()[1], colors.bg)
          return leftbracket
        end,
        highlight = 'ViModeHighlight'
      }
    },
    {
      ViModeIconAndText = {
        provider = function()
          highlight('GalaxyViMode', colors.modetext, get_mode()[1])
          return icons['vim'] .. " " .. get_mode()[2]
        end,
        highlight = 'GalaxyViMode'
      }
    },
    {
      ViModeRight = {
        provider = providers.fixed_string(rightbracket),
        separator = ' ',
        separator_highlight = 'ViModeHighlight',
        highlight = 'ViModeHighlight'
      }
    },
  }
  -- Git info

  -- Git Branch Name
  table.extends(gls.left) {
    {
      GitStart = {
        provider = providers.fixed_string(leftbracket),
        condition = condition.check_git_workspace,
        highlight = { colors.giticon, colors.bg }
      }
    },
    {
      GitIcon = {
        provider = providers.fixed_string(' ', ''),
        condition = condition.check_git_workspace,
        separator = '',
        separator_highlight = { 'NONE', colors.giticon },
        highlight = { colors.gitbg, colors.giticon }
      }
    },
    {
      GitMid = {
        provider = providers.fixed_string(rightbracket, ' '),
        condition = condition.check_git_workspace,
        highlight = { colors.giticon, colors.gitbg }
      }
    },
  }

  -- Git Changes
  table.extends(gls.left) {
    {
      DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.check_git_workspace,
        icon = '  ',
        highlight = { colors.green, colors.gitbg }
      }
    },
    {
      DiffModified = {
        provider = 'DiffModified',
        condition = condition.check_git_workspace,
        icon = ' 柳',
        highlight = { colors.blue, colors.gitbg }
      }
    },
    {
      DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.check_git_workspace,
        icon = '  ',
        highlight = { colors.red, colors.gitbg }
      }
    },
    {
      EndGit = {
        provider = providers.fixed_string(rightbracket),
        condition = condition.check_git_workspace,
        separator = " ",
        separator_highlight = {colors.gitbg, colors.bg},
        highlight = { colors.gitbg, colors.bg }
      }
    },
  }

  -- Lsp Section

  -- Lsp Client
  table.extends(gls.left) {
    {
      LspStart = {
        provider = providers.fixed_string(leftbracket),
        highlight = {colors.lspicon, colors.bg}
      }
    },
    {
      LspIcon = {
        provider = function()
          local name = ''
          if gl.lspclient ~= nil then
            name = gl.lspclient()
          end
          return '' .. name
        end,
        highlight = { colors.lspbg, colors.lspicon }
      }
    },
    {
      LspMid = {
        provider = providers.fixed_string(rightbracket, ' '),
        highlight = { colors.lspicon, colors.lspbg }
      }
    },
    {
      ShowLspClient = {
        provider = 'GetLspClient',
        highlight = { colors.textbg, colors.lspbg }
      }
    },
    {
      LspSpace = {
        provider = providers.space(),
        highlight = { colors.lspicon, colors.lspbg }
      }
    },
    {
      LspStatus = {
        provider = providers.lsp_status(),
        highlight = { colors.textbg, colors.lspbg }
      },
    },
  }

  -- Diagnostics
  table.extends(gls.left) {
    {
      DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        separator_highlight = {colors.gitbg, colors.bg},
        highlight = { colors.diagerror, colors.lspbg }
      }
    },
    {
      DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = { colors.diagwarn, colors.lspbg }
      }
    },
    {
      DiagnosticHint = {
        provider = 'DiagnosticHint',
        icon = '  ',
        highlight = { colors.diaghint, colors.lspbg }
      }
    },
    {
      DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = '  ',
        highlight = { colors.diaginfo, colors.lspbg }
      }
    },
    {
      LspSectionEnd = {
        provider = providers.fixed_string(rightbracket, ' '),
        highlight = { colors.lspbg, colors.bg }
      }
    },
  }

  -- Right
  gls.right = {}

  -- Type
  table.extends(gls.right) {
    {
      TypeStart = {
        provider = providers.fixed_string(leftbracket),
        highlight = { colors.typeicon, colors.bg }
      }
    },
    {
      TypeFileFormatIcon = {
        provider = function()
          local icon = icons[vim.bo.fileformat] or ''
          return string.format(' %s', icon)
        end,
        highlight = { colors.typebg, colors.typeicon }
      }
    },
    {
      TypeMid = {
        provider = providers.fixed_string(rightbracket, ' '),
        highlight = { colors.typeicon, colors.typebg }
      }
    },
    {
      FileName = {
        provider = 'FileName',
        separator_highlight = { 'NONE', colors.typebg },
        highlight = { colors.typetext, colors.typebg }
      }
    },
    {
      FileIcon = {
        provider = 'FileIcon',
        highlight = { colors.typeicon, colors.typebg }
      }
    },
    {
      BufferType = {
        provider = 'FileTypeName',
        highlight = { colors.typetext, colors.typebg }
      }
    },
    {
      FileSize = {
        provider = 'FileSize',
        separator = '  ',
        separator_highlight = {colors.typeicon, colors.typebg},
        highlight = { colors.typetext, colors.typebg }
      }
    },
    {
      FileEncode = {
        provider = 'FileEncode',
        separator = '',
        separator_highlight = { colors.typeicon, colors.typebg },
        highlight = { colors.typetext, colors.typebg }
      }
    },
    {
      TypeSectionEnd = {
        provider = providers.fixed_string(rightbracket),
        highlight = { colors.typebg, colors.bg }
      }
    },
    {
      Space = {
        provider = providers.space(),
        highlight = { colors.typebg, colors.bg }
      }
    },
  }

  -- Cursor Position Section
  table.extends(gls.right) {
    {
      StatsSectionStart = {
        provider = providers.fixed_string(leftbracket),
        highlight = { colors.statsicon, colors.bg }
      }
    },
    {
      StatsIcon = {
        provider = providers.fixed_string('⅑'),
        highlight = { colors.statsbg, colors.statsicon }
      }
    },
    {
      StatsMid = {
        provider = providers.fixed_string(rightbracket, ' '),
        highlight = { colors.statsicon, colors.statsbg }
      }
    },
    {
      PerCent = {
        provider = 'LinePercent',
        highlight = { colors.statstext, colors.statsbg }
      }
    },
    {
      VerticalPosAndSize = {
        provider = function()
          return string.format("%4i/%4i ", vim.fn.line('.'), vim.fn.line('$'))
        end,
        separator = '⇕ ',
        separator_highlight = { colors.statsicon, colors.statsbg },
        highlight = { colors.statstext, colors.statsbg }
      }
    },
    {
      CursorColumnStart = {
        provider = providers.fixed_string(leftbracket),
        separator = '⇔ ',
        separator_highlight = { colors.statsicon, colors.statsbg },
        highlight = 'LinePosHighlightStart'
      }
    },
    {
      CursorColumn = {
        provider = function()
          setLineWidthColours()
          return " " .. string.format("%3i", vim.fn.col('.')) .. "/"
        end,
        highlight = 'LinePosHighlightColNum'
      }
    },
    {
      LineLengthStart = {
        provider = providers.fixed_string(' ', leftbracket),
        highlight = 'LinePosHighlightMid'
      }
    },
    {
      LineLength = {
        provider = function()
          return ' ' .. string.format("%3i", string.len(vim.fn.getline('.')))
        end,
        highlight = 'LineLenHighlightLenNum'
      }
    },
    {
      LineLengthEnd = {
        provider = providers.fixed_string(' ', rightbracket),
        highlight = 'LinePosHighlightEnd'
      }
    },
    {
      TabOrSpace = {
        provider = function()
          if vim.bo.expandtab then
            return '⯀'
          else
            return '⯈'
          end
        end,
        condition = condition.hide_in_width,
        highlight = { colors.statsicon, colors.statsbg }
      }
    },
    {
      Tabstop = {
        provider = function()
          if vim.bo.expandtab then
            return vim.bo.shiftwidth
          else
            return vim.bo.shiftwidth
          end
        end,
        condition = condition.hide_in_width,
        highlight = { colors.statstext, colors.statsbg }
      }
    },
    {
      StatsSpcSectionEnd = {
        provider = providers.fixed_string(rightbracket, ' '),
        highlight = { colors.statsbg, colors.bg }
      }
    },
  }

  -- Left Short
  gls.short_line_left={
    {
      ShortSectionStart = {
        provider = providers.fixed_string(leftbracket),
        highlight = { colors.shortbg, colors.bg }
      }
    },
    {
      ShortSectionSpace = {
        provider = providers.space(),
        highlight = {colors.shorttext, colors.shortbg}
      }
    },
    {
      LeftShortName = {
        provider = 'FileTypeName',
        highlight = { colors.shorttext, colors.shortbg },
      }
    },
    {
      ShortSectionMid = {
        provider = providers.space(),
        highlight = { colors.shortbg, colors.shortbg }
      }
    },
    {
      LeftShortFileName = {
        provider = 'SFileName',
        condition = condition.buffer_not_empty,
        separator_highlight = { colors.shorttext, colors.shortbg },
        highlight = { colors.shorttext, colors.shortbg },
      }
    },
    {
      ShortSectionEnd = {
        provider = providers.fixed_string(rightbracket),
        highlight = { colors.shortbg, colors.bg }
      }
    },
  }

  -- Right Short
  gls.short_line_right = {
    {
      BufferIcon = {
        provider = 'BufferIcon',
        separator_highlight = { colors.shorttext, colors.bg },
        highlight = { colors.shortrighttext, colors.bg }
      }
    }
  }
end
