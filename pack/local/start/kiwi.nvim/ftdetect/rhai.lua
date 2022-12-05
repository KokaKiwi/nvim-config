vim.augroup('kiwiJust', function()
  local patterns = { '*.rhai' }

  vim.aubufread(patterns, function()
    vim.bo.filetype = 'rhai'
    vim.bo.commentstring = '# %s'
    vim.bo.comments = ':#'
  end)
end)
