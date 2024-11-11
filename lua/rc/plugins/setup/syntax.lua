local M = {}

function M.setup_polyglot()
  prefixed(vim.g, 'polyglot') {
    disabled = {
      'fish', 'systemd', 'nftables', 'lifelines',
      'php', 'graphql', 'just',
    },
  }
end

return M
