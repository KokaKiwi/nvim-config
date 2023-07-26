vim.augroup('kiwiPRQL', function()
  local patterns = { '*.prql' }

  vim.aubufread(patterns, function()
    vim.bo.filetype = 'prql'
    vim.bo.commentstring = '# %s'
    vim.bo.comments = ':#'
  end)
end)
