vim.augroup('witx', function()
  local patterns = { '*.witx' }

  vim.aubufread(patterns, function()
    vim.bo.filetype = 'witx'
    vim.bo.commentstring = ';; %s'
    vim.bo.comments = ':;;'
  end)
end)
