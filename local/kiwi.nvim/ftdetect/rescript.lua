local group = vim.api.nvim_create_augroup('kiwiReScript', {})

vim.aubufread({ '*.res', '*.resi' }, function()
  vim.bo.filetype = 'rescript'
end, { group = group })
