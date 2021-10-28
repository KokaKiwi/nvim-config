local M = {}

function M.setup_neorg()
  require('neorg').setup {
    load = {
      ['core.defaults'] = {},
      ['core.norg.concealer'] = {},
      ['core.norg.dirman'] = {},
    },
  }
end

return M
