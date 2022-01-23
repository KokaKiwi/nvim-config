local logo = require('kiwi.ui.dashboard.logo')
local util = require('kiwi.ui.dashboard.util')

local function count_plugins()
  local loaded_plugins, total_plugins = 0, 0

  ---@diagnostic disable-next-line
  for _, plugin in pairs(packer_plugins) do
    total_plugins = total_plugins + 1
    if plugin.loaded then
      loaded_plugins = loaded_plugins + 1
    end
  end

  return loaded_plugins, total_plugins
end

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
  nvim_version = string.format(
    'v%i.%i.%i (API level: %i)',
    nvim_version.major,
    nvim_version.minor,
    nvim_version.patch,
    nvim_version.api_level
  )

  local loaded_plugins, total_plugins = count_plugins()

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
      util.text { string.format('Plugins: %i loaded / %i total', loaded_plugins, total_plugins),
        hl = 'NonText',
      },
      util.text { string.format('neovim %s', nvim_version),
        hl = 'NonText',
      }
    },
  }

  require('alpha').setup {
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
