local M = {}

function M.setup_nu()
  require('nu').setup {
    complete_cmd_names = false,
  }
end

function M.setup_polyglot()
  print('prout')
  prefixed(vim.g, 'polyglot') {
    disabled = { 'fish', 'systemd', 'nftables', 'lifelines' },
  }
end

return M
