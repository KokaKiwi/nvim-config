vim.after = {
  _callbacks = {},

  register = function(cb)
    table.insert(vim.after._callbacks, cb)
  end,

  run = function()
    for _, cb in pairs(vim.after._callbacks) do
      cb()
    end
  end,
}
