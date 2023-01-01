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

function vim.lsp.util.get_line(uri, row)
  local uv = vim.loop
  -- load the buffer if this is not a file uri
  -- Custom language server protocol extensions can result in servers sending URIs with custom schemes. Plugins are able to load these via `BufReadCmd` autocmds.
  if uri:sub(1, 4) ~= "file" then
    local bufnr = vim.uri_to_bufnr(uri)
    vim.fn.bufload(bufnr)
    return (vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false) or { "" })[1]
  end

  local filename = vim.uri_to_fname(uri)

  -- use loaded buffers if available
  if vim.fn.bufloaded(filename) == 1 then
    local bufnr = vim.fn.bufnr(filename, false)
    return (vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false) or { "" })[1]
  end

  local fd = uv.fs_open(filename, "r", 438)
  -- TODO: what should we do in this case?
  if not fd then return "" end
  local stat = uv.fs_fstat(fd)
  local data = uv.fs_read(fd, stat.size, 0)
  uv.fs_close(fd)

  local lnum = 0
  for line in string.gmatch(data, "([^\n]*)\n?") do
    if lnum == row then return line end
    lnum = lnum + 1
  end
  return ""
end
