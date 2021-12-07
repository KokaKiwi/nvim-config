vim.augroup('kiwiJust', function()
  vim.aubufread('Justfile', { ft = 'just' })
end)
