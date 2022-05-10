local config = {
  _handlers = {},
}

function config.register(name, handler)
  local handlers = config._handlers[name]
  if handlers == nil then
    handlers = {}
    config._handlers[name] = handlers
  end

  table.append(handlers, handler)
end

function config.run(name, data)
  local handlers = config._handlers[name] or {}

  data = data or {}

  for _, handler in ipairs(handlers) do
    local res = handler(data)
    if res ~= nil then
      data = res
    end
  end

  return data
end

return config
