---@diagnostic disable: unused-local
local lsp = {}

local AUTO_FORMAT_PATTERNS = { '*.rs', '*.ex', '*.exs', '*.hs' }

function lsp.setup()
  require('kiwi.lsp.langs')

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
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

  vim.augroup('KiwiLsp', function()
    vim.autocmd('BufWritePre', AUTO_FORMAT_PATTERNS, function()
      vim.lsp.buf.format { async = true }
    end)
  end)
end

return lsp
