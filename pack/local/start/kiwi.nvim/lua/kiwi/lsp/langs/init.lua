local configs = require('lspconfig/configs')

-- Import custom LSP clients
local LANGUAGES = {}
for name, mod in pairs(LANGUAGES) do
  if type(mod) == 'string' then
    mod = { mod = mod }
  end
  mod.name = name

  if mod.force or configs[mod.name] == nil then
    require('kiwi.lsp.langs.' .. mod.mod)
  end
end

-- Utils
local function get_lua_runtime_paths()
  local runtime_paths = vim.split(package.path, ';')
  table.insert(runtime_paths, 'lua/?.lua')
  table.insert(runtime_paths, 'lua/?/init.lua')
  return runtime_paths
end

-- Setup Language Servers
require('kiwi.lsp.langs.hack')
local lsp = require('lspconfig')
local util = require('lspconfig/util')
local lsp_status = require('lsp-status')

local schemastore = require('schemastore')

lsp.bashls.setup {}
lsp.clangd.setup {
  handlers = lsp_status.extensions.clangd.setup(),
}
lsp.cmake.setup {}
lsp.dhall_lsp_server.setup {}
lsp.dockerls.setup {}
lsp.elixirls.setup {
  cmd = { 'elixir-ls' },
  root_dir = function(fname)
    return util.root_pattern('.git')(fname) or util.root_pattern('mix.exs')(fname) or vim.loop.os_homedir()
  end,
}
lsp.gopls.setup {}
lsp.hls.setup {}
lsp.jsonls.setup {
  settings = {
    json = {
      schemas = schemastore.json.schemas(),
    },
  },
}
lsp.sumneko_lua.setup {
  cmd = { 'lua-language-server' },
  settings = {
    Lua = {
      hint = {
        enable = true,
      },
      runtime = {
        version = 'LuaJIT',
        path = get_lua_runtime_paths(),
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
lsp.phpactor.setup {}
lsp.pyright.setup {}
lsp.rnix.setup {}
lsp.scry.setup {}
lsp.solargraph.setup {}
lsp.sqlls.setup {
  cmd = { 'sql-language-server', 'up', '--method', 'stdio' }
}
lsp.texlab.setup {}
lsp.tsserver.setup {
  cmd = { 'javascript-typescript-stdio' },
}
lsp.vimls.setup {}
lsp.yamlls.setup {}
