local M = {}

function M.setup_committia()
  require('committia').setup {
    vcs = {
      git = false,
    }
  }
end

return M
