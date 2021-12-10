local function severity_lsp_to_vim(severity)
  if type(severity) == 'string' then
    severity = vim.lsp.protocol.DiagnosticSeverity[severity]
  end
  return severity
end

local function severity_vim_to_lsp(severity)
  if type(severity) == 'string' then
    severity = vim.diagnostic.severity[severity]
  end
  return severity
end

local function diagnostic_vim_to_lsp(diagnostics)
  return vim.tbl_map(function(diagnostic)
    return vim.tbl_extend("error", {
      range = {
        start = {
          line = diagnostic.lnum,
          character = diagnostic.col,
        },
        ["end"] = {
          line = diagnostic.end_lnum,
          character = diagnostic.end_col,
        },
      },
      severity = severity_vim_to_lsp(diagnostic.severity),
      message = diagnostic.message,
      source = diagnostic.source,
    }, diagnostic.user_data and (diagnostic.user_data.lsp or {}) or {})
  end, diagnostics)
end

function vim.lsp.diagnostic.get(bufnr, client_id, _)
  local opts = {}
  if client_id ~= nil then
    opts.namespace = vim.lsp.diagnostic.get_namespace(client_id)
  end

  return diagnostic_vim_to_lsp(vim.diagnostic.get(bufnr, opts))
end

function vim.lsp.diagnostic.get_all(client_id)
  return vim.lsp.diagnostic.get(nil, client_id)
end

function vim.lsp.diagnostic.get_count(bufnr, severity, client_id)
  local opts = {
    severity = severity_lsp_to_vim(severity)
  }
  if client_id ~= nil then
    opts.namespace = vim.lsp.diagnostic.get_namespace(client_id)
  end

  return #vim.diagnostic.get(bufnr, opts)
end
