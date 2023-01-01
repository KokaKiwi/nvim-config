---vim.hi
function vim.hi(cmd, opts)
  opts = opts or {}

  local command = { 'highlight' }
  if type(cmd) == 'string' then
    table.insert(command, cmd)
  elseif type(cmd) == 'table' then
    table.extends(command, cmd)
  end
  table.extends(command, table.dmap(opts, function(key, value)
    return string.format('%s=%s', key, value)
  end, true))

  vim.cmd(string.join(' ', command))
end
