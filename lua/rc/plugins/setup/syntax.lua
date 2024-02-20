local M = {}

function M.setup_nu()
  require('nu').setup {
    complete_cmd_names = false,
  }
end

function M.setup_polyglot()
  prefixed(vim.g, 'polyglot') {
    disabled = {
      'fish', 'systemd', 'nftables', 'lifelines',
      'php', 'graphql', 'just',
    },
  }
end

return M
