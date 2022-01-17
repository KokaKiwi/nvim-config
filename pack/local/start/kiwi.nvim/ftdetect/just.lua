vim.augroup('kiwiJust', function()
  vim.aubufread('Justfile', function()
    vim.bo.filetype = 'just'
    vim.bo.commentstring = '# %s'
    vim.bo.comments = ':#'
  end)
end)
