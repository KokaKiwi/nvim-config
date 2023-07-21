-- [nfnl] Compiled from fnl/klib/stdlib/new/class.fnl by https://github.com/Olical/nfnl, do not edit.
require("klib.stdlib.table")
local function new(init, base, mt)
  local base0
  if (base ~= nil) then
    base0 = base
  else
    base0 = {}
  end
  local function _2_(...)
    local base1 = table.copy(base0, false)
    local obj = setmetatable(base1, mt)
    init(obj, ...)
    return obj
  end
  return _2_
end
_G.class = {new = new}
return _G.class
