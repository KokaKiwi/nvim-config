local systemd_exts = {
  'unit', 'service', 'socket', 'device', 'mount', 'automount',
  'swap', 'target', 'path', 'timer', 'slice', 'scope', 'nspawn',
  'link', 'netdev', 'network',
}

vim.augroup('systemd', function()
  local systemd_pats = table.map(systemd_exts, function(ext)
    return string.format('*.%s', ext)
  end)

  vim.autocmd({ 'BufNewFile', 'BufRead' }, systemd_pats, 'setf systemd')
  vim.autocmd({ 'BufNewFile', 'BufRead' }, '*/systemd/*.conf', 'setf systemd')
end)
