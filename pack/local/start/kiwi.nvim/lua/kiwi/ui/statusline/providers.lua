local lsp_status = require('lsp-status')

local providers = {}

function providers.empty()
  return ' '
end

function providers.lsp_status()
  local status = lsp_status.status()

  return tostring(status)
end

return providers
