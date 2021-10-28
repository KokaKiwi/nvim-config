local configs = require('lspconfig/configs')
local util = require('lspconfig/util')

local meta = getmetatable(configs)
local meta_newindex = meta.__newindex

meta.__newindex = function(t, config_name, config_def)
  local mod = meta_newindex({}, config_name, config_def)

  local default_config = vim.tbl_extend('keep', config_def.default_config, util.default_config)

  local setup = mod.setup
  function mod.setup(config)
    local final_config = vim.tbl_extend('keep', config, default_config)

    local exename = final_config.cmd[1]
    if not fs.is_executable(exename) then
      return
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_extend('keep', capabilities, require('lsp-status').capabilities)
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    if config.capabilities ~= nil then
      capabilities = vim.tbl_extend('keep', capabilities, config.capabilities)
    end
    config.capabilities = capabilities

    local on_attach = config.on_attach
    function config.on_attach(client, bufnr)
      require('lsp-status').on_attach(client, bufnr)
      require('illuminate').on_attach(client, bufnr)
      require('navigator.lspclient.attach').on_attach(client, bufnr)

      -- Lastly, let user config setup
      if on_attach ~= nil then
        on_attach(client, bufnr)
      end
    end

    setup(config)
  end

  rawset(t, config_name, mod)
end
