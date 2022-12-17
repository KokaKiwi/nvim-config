vim.augroup('kiwiKdl', function()
  local patterns = { '*.kdl' }

  vim.aubufread(patterns, function()
    vim.bo.filetype = 'kdl'
    vim.bo.commentstring = '// %s'
    vim.bo.comments = '://'
  end)
end)
