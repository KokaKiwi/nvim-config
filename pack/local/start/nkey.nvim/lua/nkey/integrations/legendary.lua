local Integration = require('nkey.integration')
local has_legendary, legendary = pcall(require, 'legendary')

return Integration.new(function(_)
  if not has_legendary then
    return
  end

  legendary.setup()
end)
