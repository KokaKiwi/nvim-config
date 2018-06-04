local lsp = require('lspconfig')

local lsp_status = require('lsp-status')

local util = {}
local meta = {}

function meta:__index(name)
  local mod = lsp[name]

  local setup = mod.setup
  local default_config = mod.document_config.default_config

  function mod.setup(config)
    local final_config = vim.tbl_extend('keep', config, default_config)
    local exename = final_config.cmd[1]

    local is_executable = vim.fn.executable(exename) == 1
    if not is_executable then
      return
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    if config.capabilities ~= nil then
      capabilities = vim.tbl_extend('keep', capabilities, config.capabilities)
    end
    config.capabilities = capabilities

    local on_attach = config.on_attach
    function config.on_attach(client, bufnr)
      lsp_status.on_attach(client)
      require('illuminate').on_attach(client)
      require('navigator.lspclient.attach').on_attach(client, bufnr)

      -- Lastly, let user config setup
      if on_attach ~= nil then
        on_attach(client, bufnr)
      end
    end

    setup(config)
  end

  return mod
end

return setmetatable(util, meta)
