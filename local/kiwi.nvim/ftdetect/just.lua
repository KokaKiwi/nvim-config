vim.augroup('kiwiJust', function()
  local patterns = {
    'Justfile', 'justfile',
    '.justfile',
    '*.just',
  }

  vim.aubufread(patterns, function()
    vim.bo.filetype = 'just'
    vim.bo.commentstring = '# %s'
    vim.bo.comments = ':#'
  end)
end)
