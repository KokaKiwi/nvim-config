local lsp_status = require('lsp-status')

local providers = {}

function providers.empty()
  return ' '
end

function providers.lsp_status()
  return tostring(lsp_status.status())
end

return providers
