local util = require('lspconfig.util')

local BASE_CAPABILITIES = {
  experimental = {
    serverStatusNotification = true,
  },
  textDocument = {
    colorProvider = {
      dynamicRegistration = true,
    },
    completion = {
      completionItem = {
        snippetSupport = true,
      },
    },
  },
}

local M = {}

local function on_attach(client, bufnr)
  require('illuminate').on_attach(client)
  require('lsp-status').on_attach(client)
  require('navigator.lspclient.attach').on_attach(client, bufnr)

  local ok, navic = pcall(require, 'nvim-navic')
  if ok then
    navic.attach(client, bufnr)
  end

  require('lsp-inlayhints').on_attach(client, bufnr)

  if client.server_capabilities.colorProvider then
    require('document-color').buf_attach(bufnr)
  end

  require('kiwi.lsp.fixups').on_attach(client, bufnr)
end

local function on_setup(config)
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  if config.capabilities ~= nil then
    capabilities = vim.tbl_deep_extend('force', capabilities, config.capabilities)
  end

  capabilities = vim.tbl_deep_extend('force', capabilities, require('lsp-status').capabilities)
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
  capabilities = vim.tbl_deep_extend('force', capabilities, BASE_CAPABILITIES)

  config.capabilities = capabilities

  local cmd = config.cmd[1]
  if vim.fn.executable(cmd) ~= 1 then
    config.autostart = false
  end

  config.on_attach = util.add_hook_before(config.on_attach, on_attach)
end

function M.register_hook()
  util.on_setup = util.add_hook_before(util.on_setup, on_setup)
end

return M
