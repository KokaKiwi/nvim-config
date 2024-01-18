vim.debug = {}

function vim.debug.print(value)
  print(vim.inspect(value))
end

function vim.debug.instrument(name, fun, opts)
  return function(...)
    print(name, vim.inspect({...}))
    return fun(...)
  end
end

function vim.debug.info(value)
  vim.debug.print(debug.getinfo(value))
end
