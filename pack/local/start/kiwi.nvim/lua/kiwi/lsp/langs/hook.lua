local util = require('lspconfig.util')

local M = {}

local function tweak_setup(config)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('lsp-status').capabilities)
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
  if config.capabilities ~= nil then
    capabilities = vim.tbl_deep_extend('force', capabilities, config.capabilities)
  end
  config.capabilities = capabilities

  local cmd = config.cmd[1]
  if vim.fn.executable(cmd) ~= 1 then
    config.autostart = false
  end

  config.on_attach = util.add_hook_before(config.on_attach, function(client, bufnr)
    require('aerial').on_attach(client, bufnr)
    require('illuminate').on_attach(client)
    require('lsp-status').on_attach(client)
    require('navigator.lspclient.attach').on_attach(client, bufnr)

    if client.server_capabilities.colorProvider then
      require('document-color').buf_attach(bufnr)
    end

    require('kiwi.lsp.fixups').on_attach(client, bufnr)
  end)

  config.on_new_config = util.add_hook_before(config.on_new_config, function(new_config, root_dir)
    local local_config_file = root_dir .. '/.nvim-lspconfig.json'
    local file = io.open(local_config_file)
    if file ~= nil then
      local data = file:read('*a')
      file:close()

      local local_config = vim.fn.json_decode(data)
      local local_settings = local_config[config.name]

      if local_settings ~= nil then
        new_config.settings = vim.tbl_deep_extend('force', new_config.settings, local_settings)
      end
    end
  end)
end

function M.register_hook()
  util.on_setup = util.add_hook_before(util.on_setup, tweak_setup)
end

return M
