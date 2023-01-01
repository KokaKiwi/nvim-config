vim.augroup('nuFiletype', function()
  local patterns = { '*.nu' }

  vim.aubufread(patterns, function()
    vim.bo.filetype = 'nu'
    vim.bo.commentstring = "# %s"
  end)
end)
