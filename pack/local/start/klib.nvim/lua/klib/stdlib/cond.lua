_G.cond = {}

function cond.if_else(value, then_value, else_value)
  if value then
    return then_value
  else
    return else_value
  end
end

function cond.prefixed(value, else_value)
  return function(then_value)
    return cond.if_else(value, then_value, else_value)
  end
end
