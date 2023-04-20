local CALLBACKS = {}

vim.after = {
  _callbacks = {},

  register = function(cb)
    table.insert(CALLBACKS, cb)
  end,

  run = function()
    for _, cb in ipairs(CALLBACKS) do
      local err, res = pcall(cb)
      if not err then
        vim.notify(
          string.format('Error on post-callback: %s', res),
          vim.log.levels.ERROR
        )
      end
    end
  end,
}
