-- string.join
function string.join(sep, strings)
  return table.concat(strings, sep)
end

function string.split(s, sep)
  if sep == nil then
    sep = '%s'
  end

  local t = {}

  for part in string.gmatch(s, '([^' .. sep .. ']+)') do
    table.insert(t, part)
  end

  return t
end
