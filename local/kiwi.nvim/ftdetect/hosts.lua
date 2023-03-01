vim.augroup('kiwiHosts', function()
  local patterns = { '/etc/hosts' }

  vim.aubufread(patterns, function()
    vim.bo.filetype = 'hosts'
    vim.bo.commentstring = '# %s'
  end)
end)
