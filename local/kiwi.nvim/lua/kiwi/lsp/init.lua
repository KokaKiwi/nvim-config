---@diagnostic disable: unused-local
local lsp = {
  methods = require('vim.lsp.protocol').Methods,
}

local AUTO_FORMAT_PATTERNS = { '*.rs', '*.ex', '*.exs', '*.hs', '*.toml', '*.go' }

local DISABLE_DIAGNOSTIC_SOURCES = {}
local DISABLE_DIAGNOSTIC_CODES = {
  -- nixd
  'sema-escaping-with', 'escaping-this-with', 'var-bind-to-this',
}

function lsp.setup()
  require('mason').setup {}

  require('kiwi.lsp.langs')

  local function on_publish_diagnostics(_, result, ctx, config)
    local function filter_diagnostic(diagnostic)
      if vim.tbl_contains(DISABLE_DIAGNOSTIC_CODES, diagnostic.code) then
        return false
      end
      if vim.tbl_contains(DISABLE_DIAGNOSTIC_SOURCES, diagnostic.source) then
        return false
      end
      return true
    end

    result.diagnostics = vim.tbl_filter(filter_diagnostic, result.diagnostics)
    vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
  end

  vim.lsp.handlers[lsp.methods.textDocument_publishDiagnostics] = vim.lsp.with(on_publish_diagnostics, {
    virtual_text = {
      spacing = 4,
      prefix = '~',
    },
    signs = function(bufnr, client_id)
      local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'show_signs')
      if not ok then
        result = true
      end
      return result
    end,
    update_in_insert = false,
  })

  vim.command('LspFormat', function()
    vim.lsp.buf.format { async = true }
  end)

  vim.command('LspSetLogLevel', function(level)
    vim.lsp.set_log_level(level)
  end, {
    complete = { 'trace', 'debug', 'info', 'warn', 'error', 'off' },
  })

  vim.augroup('KiwiLsp', function()
    vim.autocmd('BufWritePre', AUTO_FORMAT_PATTERNS, function()
      vim.lsp.buf.format { async = true }
    end)
  end)
end

return lsp
