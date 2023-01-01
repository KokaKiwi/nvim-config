local util = require('rc.plugins.util')

local local_plugins_path = vim.fn.stdpath('config') .. '/local'

return util.module('local', function(use)
  local function use_local(name)
    use {
      dir = local_plugins_path .. '/' .. name,
    }
  end

  use_local 'kiwi.nvim'
  use_local 'nkey.nvim'
  use_local 'nvim-hook.lua'

  use_local 'fennel.vim'
  use_local 'rhai.vim'
  use_local 'systemd.nvim'
  use_local 'vim-nftables'
end)
