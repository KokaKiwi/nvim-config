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

---@class _NvimVersion
---@field major integer
---@field minor integer
---@field patch integer
---@field api_level integer

return function()
  local alpha = require('alpha')
  local lazy = require('lazy')
  local startuptime = 0

  local header = {
    type = 'group',
    val = {
      util.text { logo(),
        hl = 'AlphaHeader',
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
        hl = 'AlphaFooter',
      },
      { type = 'padding', val = 4 },
      util.text {
        function()
          if startuptime == 0 then
            return ''
          end
          return string.format('Started in %ims', startuptime)
        end,
        hl = 'NonText',
      },
      util.text {
        function()
          local lazy_stats = lazy.stats()
          return string.format('Plugins: %i loaded / %i total', lazy_stats.loaded, lazy_stats.count)
        end,
        hl = 'NonText',
      },
      util.text {
        function()
          ---@class _NvimVersion
          local nvim_version = vim.version()

          return string.format('Neovim %s (API level: %i)', tostring(nvim_version), nvim_version.api_level)
        end,
        hl = 'NonText',
      }
    },
  }

  vim.api.nvim_create_autocmd('User', {
    pattern = { 'LazyVimStarted', 'LazyLoad' },
    callback = function()
      local lazy_stats = lazy.stats()
      startuptime = lazy_stats.startuptime

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
