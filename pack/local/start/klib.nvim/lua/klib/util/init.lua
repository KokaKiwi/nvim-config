function klib.prefixed(t, prefix, sep)
  if sep == nil then
    sep = '_'
  end

  return function(values)
    for key, value in pairs(values) do
      t[string.format('%s%s%s', prefix, sep, key)] = value
    end
  end
end
_G.prefixed = klib.prefixed

function klib.is_nvim_headless()
  return #vim.api.nvim_list_uis() == 0
end
