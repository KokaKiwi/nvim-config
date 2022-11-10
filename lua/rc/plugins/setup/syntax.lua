local M = {}

function M.setup_nu()
  require('nu').setup {
    complete_cmd_names = false,
  }
end

return M
