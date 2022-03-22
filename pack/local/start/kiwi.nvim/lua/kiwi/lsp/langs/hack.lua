local configs = require('lspconfig.configs')
local util = require('lspconfig.util')

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
    capabilities = vim.tbl_deep_extend('keep', capabilities, require('lsp-status').capabilities)
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    if config.capabilities ~= nil then
      capabilities = vim.tbl_deep_extend('force', capabilities, config.capabilities)
    end
    config.capabilities = capabilities

    local on_attach = config.on_attach
    function config.on_attach(client, bufnr)
      require('aerial').on_attach(client, bufnr)
      require('illuminate').on_attach(client)
      require('lsp-status').on_attach(client)
      require('lsp_signature').on_attach({
        bind = false,
      }, bufnr)
      require('navigator.lspclient.attach').on_attach(client, bufnr)
      require('kiwi.lsp.fixups').on_attach(client, bufnr)

      -- Lastly, let user config setup
      if on_attach ~= nil then
        on_attach(client, bufnr)
      end
    end

    local on_new_config = config.on_new_config
    function config.on_new_config(new_config, root_dir)
      local local_config_file = root_dir .. '/.nvim-lspconfig.json'
      local file = io.open(local_config_file)
      if file ~= nil then
        local data = file:read('*a')
        file:close()

        local local_config = vim.fn.json_decode(data)
        local local_settings = local_config[config_name]

        if local_settings ~= nil then
          new_config.settings = vim.tbl_deep_extend('force', new_config.settings, local_settings)
        end
      end

      if on_new_config ~= nil then
        on_new_config(new_config, root_dir)
      end
    end

    setup(config)
  end

  rawset(t, config_name, mod)
end
