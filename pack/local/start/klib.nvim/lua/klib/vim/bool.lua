bool = {}

-- bool.select
function bool.select(expr, then_expr, else_expr)
  if expr then
    return then_expr
  else
    return else_expr
  end
end

-- should be here,,
vim.TRUE = 1
vim.FALSE = 0

-- vim.luabool
function vim.luabool(value)
  return value ~= vim.FALSE
end

-- vim.vimbool
function vim.vimbool(value)
  if value then
    return vim.TRUE
  else
    return vim.FALSE
  end
end
