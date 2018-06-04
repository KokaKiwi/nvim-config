local notify = require('notify')

notify.setup {
  stages = 'fade',
}

local function create_notifier(level)
  return function(msg, opts)
    return notify(msg, level, opts)
  end
end
vim.notify = {
  trace = create_notifier('trace'),
  debug = create_notifier('debug'),
  info = create_notifier('info'),
  warn = create_notifier('warn'),
  error = create_notifier('error'),
}
setmetatable(vim.notify, {
  __call = function(_, msg, level, opts)
    return notify(msg, level, opts)
  end,
})
