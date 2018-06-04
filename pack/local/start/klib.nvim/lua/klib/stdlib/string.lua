-- string.join
function string.join(sep, strings)
  local result = ''

  for i, s in ipairs(strings) do
    if i > 0 then
      result = result .. sep
    end

    result = result .. s
  end

  return result
end
