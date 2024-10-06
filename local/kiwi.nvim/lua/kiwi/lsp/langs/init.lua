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

-- Setup Language Servers
local schemastore = require('schemastore')

require('kiwi.lsp.langs.hook').register_hook()
require('mason-lspconfig').setup {}
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

local lsp = require('lspconfig')

require('mason-lspconfig').setup_handlers {
  function(server_name)
    lsp[server_name].setup {}
  end,
}

lsp.bashls.setup {
  filetypes = { 'sh' },
}
lsp.clangd.setup {}
lsp.cmake.setup {}
lsp.cssls.setup {
  cmd = { 'vscode-css-languageserver', '--stdio' },
}
lsp.dhall_lsp_server.setup {}
lsp.dockerls.setup {}
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
lsp.lua_ls.setup {
  cmd = { 'lua-language-server' },
}
lsp.nim_langserver.setup {}
lsp.nixd.setup {
  cmd = {
    'nixd',
    '--inlay-hints=true',
    '--semantic-tokens=true',
  },
}
lsp.phpactor.setup {}
-- lsp.pyright.setup {}
lsp.pylsp.setup {}
lsp.rhai_lsp.setup {}
lsp.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {
      assist = {
        emitMustUse = true,
      },
      checkOnSave = {
        command = 'clippy',
      },
      completion = {
        callable = {
          snippets = 'add_parentheses',
        },
      },
    },
  },
}
lsp.scry.setup {}
lsp.solargraph.setup {}
lsp.sqlls.setup {
  cmd = { 'sql-language-server', 'up', '--method', 'stdio' }
}
lsp.taplo.setup {}
lsp.texlab.setup {}
lsp.ts_ls.setup {}
lsp.vimls.setup {}
lsp.vuels.setup {}
lsp.yamlls.setup {}
lsp.ziggy.setup {}
lsp.ziggy_schema.setup {}
lsp.zls.setup {}
