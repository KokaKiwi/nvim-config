vim.api.nvim_create_user_command('Just', function(opts)
  opts = opts or {}

  require('FTerm').scratch {
    cmd = { 'just', unpack(opts.fargs or {}) },
    border = 'double',
    dimensions = {
      width = 0.9,
      height = 0.9,
    },
  }
end, {
  nargs = '*',
})
