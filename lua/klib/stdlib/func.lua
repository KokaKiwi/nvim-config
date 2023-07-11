-- [nfnl] Compiled from fnl/klib/stdlib/func.fnl by https://github.com/Olical/nfnl, do not edit.
local function lua_partial(f, ...)
  local pargs = {...}
  local function _1_(...)
    local args = {...}
    return f(unpack(table.join(pargs, args)))
  end
  return _1_
end
_G.func = {partial = lua_partial}
return nil
