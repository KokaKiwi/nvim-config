---@diagnostic disable: unused-local
local lsp = {}

local AUTO_FORMAT_PATTERNS = { '*.rs', '*.ex', '*.exs' }

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

  vim.command('LspRestart', function()
    local posix = require('posix')
    local configs = require('lspconfig/configs')

    vim.notify.info('Stopping LSP clients...')
    local clients = vim.lsp.get_active_clients()
    for _, client in ipairs(clients) do
      client.stop()
    end

    posix.sleep(1)

    vim.notify.info('Starting LSP clients...')
    local buffer_filetype = vim.bo.filetype
    for _, config in pairs(configs) do
      for _, filetype_match in ipairs(config.filetypes or {}) do
        if buffer_filetype == filetype_match then
          config.autostart()
        end
      end
    end
  end)

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
