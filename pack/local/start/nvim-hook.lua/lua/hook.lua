local Hook = {}

function Hook.new()
  local hook = {
    handlers = {},
  }

  return setmetatable(hook, Hook)
end
Hook.__index = Hook

function Hook:register(handler)
  table.insert(self.handlers, handler)
  return handler
end

function Hook:run(...)
  for _, handler in ipairs(self.handlers) do
    handler(...)
  end
end

return Hook
