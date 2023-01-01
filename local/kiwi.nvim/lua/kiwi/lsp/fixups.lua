local function fixup_document_highlight()
  local document_highlight_handler = vim.lsp.handlers['textDocument/documentHighlight']
  if document_highlight_handler ~= nil then
    vim.lsp.handlers['textDocument/documentHighlight'] = function(err, result, ctx)
      if not result or not result[1] then
        return
      end

      document_highlight_handler(err, result, ctx)
    end
  end
end

local function on_attach(_, _)
  fixup_document_highlight()
end

return { on_attach = on_attach }
