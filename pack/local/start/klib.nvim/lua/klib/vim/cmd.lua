-- vim.autocmd
vim.autocmd_table = {}

---@param events string | string[]
---@param pattern string | string[]
---@param cmd string | function
---@param opts table
function vim.autocmd(events, pattern, cmd, opts)
  opts = opts or {}

  if vim.tbl_islist(events) then
    events = table.concat(events, ',')
  end
  if vim.tbl_islist(pattern) then
    pattern = table.concat(pattern, ',')
  end

  local command = { 'autocmd' }

  if opts.group ~= nil then
    table.insert(command, opts.group)
  end

  table.insert(command, events)
  table.insert(command, pattern)

  if opts.once ~= nil then
    table.insert(command, '++once')
  end
  if opts.nested ~= nil then
    table.insert(command, '++nested')
  end

  if type(cmd) == 'function' then
    local index = #vim.autocmd_table + 1
    vim.autocmd_table[index] = cmd
    cmd = string.format('lua vim.autocmd_table[%d]()', index)
  end
  table.insert(command, cmd)

  vim.cmd(table.concat(command, ' '))
end

---@param filetype string | string[]
---@param cmd string | function
---@param opts table
function vim.aufiletype(filetype, cmd, opts)
  vim.autocmd('FileType', filetype, cmd, opts)
end

-- vim.command
vim.command_table = {}

---@param name string
---@param repl string | function
---@param opts table
function vim.command(name, repl, opts)
  opts = opts or {}

  local command = { 'command!', '-nargs=*' }

  if opts.complete ~= nil then
    table.insert(command, string.format('-complete=%s', opts.complete))
  end
  if opts.range ~= nil then
    if type(opts.range) == 'boolean' and opts.range then
      table.insert(command, '-range')
    else
      table.insert(command, string.format('-range=%s', opts.range))
    end
  end
  if opts.addr ~= nil then
    table.insert(command, string.format('-addr=%s', opts.addr))
  end

  table.insert(command, name)

  if type(repl) == 'function' then
    local index = #vim.command_table + 1
    vim.command_table[index] = repl
    repl = string.format('lua vim.command_table[%d](<f-args>)', index)
  end
  table.insert(command, repl)

  vim.cmd(table.concat(command, ' '))
end

-- vim.augroup
function vim.augroup(name, fn)
  vim.cmd(string.format('augroup %s', name))
  vim.cmd('autocmd!')

  pcall(fn)

  vim.cmd('augroup end')
end
