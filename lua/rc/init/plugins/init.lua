function prefixed(t, prefix, sep)
  if sep == nil then
    sep = '_'
  end

  return function(values)
    for key, value in pairs(values) do
      t[string.format('%s%s%s', prefix, sep, key)] = value
    end
  end
end

require_prefix('rc.init.plugins', { 'helpers', 'syntax', 'ui', 'utils' })
