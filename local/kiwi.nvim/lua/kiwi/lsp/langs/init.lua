local configs = require('lspconfig.configs')

-- Import custom LSP clients
local LANGUAGES = {
  rhai_lsp = 'rhai_lsp',
}
for name, mod in pairs(LANGUAGES) do
  if type(mod) == 'string' then
    mod = { mod = mod }
  end
  mod.name = name

  if mod.force or configs[mod.name] == nil then
    configs[mod.name] = require('kiwi.lsp.langs.' .. mod.mod)
  end
end

-- Setup LSP installer
require('mason-lspconfig').setup {}

-- Setup Language Servers
require('kiwi.lsp.langs.hook').register_hook()
local lsp = require('lspconfig')
local util = require('lspconfig.util')

local lsp_status = require('lsp-status')
local schemastore = require('schemastore')

require('neodev').setup {
  library = {
    plugins = { 'nvim-dap-ui' },
    types = true,
  },
}
require('neoconf').setup {
  import = {
    coc = false,
  },
}

lsp.bashls.setup {
  filetypes = { 'sh' },
}
lsp.clangd.setup {
  handlers = lsp_status.extensions.clangd.setup(),
}
lsp.cmake.setup {}
lsp.cssls.setup {
  cmd = { 'vscode-css-languageserver', '--stdio' },
}
lsp.dhall_lsp_server.setup {}
lsp.dockerls.setup {}
lsp.elixirls.setup {
  cmd = { 'elixir-ls' },
  root_dir = function(fname)
    return util.root_pattern('.git')(fname) or util.root_pattern('mix.exs')(fname) or vim.loop.os_homedir()
  end,
}
lsp.gleam.setup {}
lsp.gopls.setup {}
lsp.jsonls.setup {
  cmd = { 'vscode-json-languageserver', '--stdio' },
  settings = {
    json = {
      schemas = schemastore.json.schemas(),
    },
  },
}
lsp.lemminx.setup {}
lsp.nimls.setup {}
lsp.lua_ls.setup {
  cmd = { 'lua-language-server' },
}
lsp.phpactor.setup {}
lsp.pyright.setup {}
lsp.rhai_lsp.setup {}
lsp.rnix.setup {}
lsp.scry.setup {}
lsp.solargraph.setup {}
lsp.sqlls.setup {
  cmd = { 'sql-language-server', 'up', '--method', 'stdio' }
}
lsp.texlab.setup {}
lsp.tsserver.setup {}
lsp.vimls.setup {}
lsp.vuels.setup {}
lsp.yamlls.setup {}
lsp.zls.setup {}
