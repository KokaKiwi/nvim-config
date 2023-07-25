---@diagnostic disable: unused-local
local lsp = {}

local AUTO_FORMAT_PATTERNS = { '*.rs', '*.ex', '*.exs', '*.hs', '*.toml', '*.go' }

function lsp.setup()
  require('mason').setup {}

  require('kiwi.lsp.langs')

  vim.command('LspFormat', function()
    vim.lsp.buf.format { async = true }
  end)

  vim.command('LspSetLogLevel', function(level)
    vim.lsp.set_log_level(level)
  end, {
    complete = { 'trace', 'debug', 'info', 'warn', 'error', 'off' },
  })

  vim.command('LspToggleInlayHints', function()
    vim.lsp.inlay_hint(0)
  end)

  vim.augroup('KiwiLsp', function()
    vim.autocmd('BufWritePre', AUTO_FORMAT_PATTERNS, function()
      vim.lsp.buf.format { async = true }
    end)
  end)
end

return lsp
