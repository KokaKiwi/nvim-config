local logo = require('kiwi.ui.dashboard.logo')
local util = require('kiwi.ui.dashboard.util')

local function infos()
  return {
    type = 'group',
    val = {
      -- <Insert fortune here>
      -- { type = 'padding', val = 1 },
      util.text { 'I use arch, btw',
        hl = 'Whitespace',
      },
    },
  }
end

return function()
  ---@class _NvimVersion
  ---@field major integer
  ---@field minor integer
  ---@field patch integer
  ---@field api_level integer
  local nvim_version = vim.version()
  local nvim_version_str = string.format(
    'v%i.%i.%i (API level: %i)',
    nvim_version.major,
    nvim_version.minor,
    nvim_version.patch,
    nvim_version.api_level
  )

  local alpha = require('alpha')
  local lazy = require('lazy')
  local lazy_stats = lazy.stats()

  local header = {
    type = 'group',
    val = {
      util.text { logo(),
        hl = 'DashboardHeader',
      },
      { type = 'padding', val = 1 },
      infos(),
    },
  }

  local main = {
    type = 'group',
    val = {
      util.button { 'e', 'New file', util.action.cmd('ene') },
    },
    opts = {
      spacing = 1,
    },
  }

  local footer = {
    type = 'group',
    val = {
      util.button { 'q', 'Quit', util.action.cmd('quitall'),
        hl = 'DashboardFooter',
      },
      { type = 'padding', val = 4 },
      util.text {
        function()
          if lazy_stats.startuptime == 0 then
            return ''
          end
          return string.format('Started in %ims', lazy_stats.startuptime)
        end,
        hl = 'NonText',
      },
      util.text {
        function()
          return string.format('Plugins: %i loaded / %i total', lazy_stats.loaded, lazy_stats.count)
        end,
        hl = 'NonText',
      },
      util.text {
        string.format('neovim %s', nvim_version_str),
        hl = 'NonText',
      }
    },
  }

  vim.api.nvim_create_autocmd('User', {
    pattern = 'LazyVimStarted',
    callback = function()
      lazy_stats = lazy.stats()
      alpha.redraw()
    end,
  })

  alpha.setup {
    layout = {
      { type = 'padding', val = 3 },
      header,
      { type = 'padding', val = 3 },
      main,
      { type = 'padding', val = 1 },
      footer,
    },
    opts = {
      margin = 5,
    },
  }
end
