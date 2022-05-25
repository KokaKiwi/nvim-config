vim.augroup('kiwiKwconfig', function()
  local patterns = { '*.kwc' }

  vim.aubufread(patterns, function()
    vim.bo.filetype = 'kwconfig'
    vim.bo.commentstring = '# %s'
    vim.bo.comments = ':#'
  end)
end)
