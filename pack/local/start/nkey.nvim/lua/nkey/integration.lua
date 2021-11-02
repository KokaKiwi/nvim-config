local Integration = {}

---@param setup_fn function
function Integration.new(setup_fn)
  local integration = {
    loaded = false,
    setup_fn = setup_fn,
  }

  return setmetatable(integration, Integration)
end
Integration.__index = Integration

function Integration:setup(nkey)
  if nkey == nil then
    nkey = require('nkey')
  end

  if self.loaded then
    return
  end

  self.setup_fn(nkey)
  self.loaded = true
end

return Integration
