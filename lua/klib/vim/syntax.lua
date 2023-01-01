vim.syn = {}

---@param mode 'match' | 'ignore'
function vim.syn.case(mode)
  vim.cmd(string.format('syn case %s', mode))
end

---@param mode 'toplevel' | 'notoplevel' | 'default'
function vim.syn.spell(mode)
  vim.cmd(string.format('syn spell %s', mode))
end

---@param value 'clear' | string | table
function vim.syn.iskeyword(value)
end

---@param group_name string Group name
---@param keywords string[]
---@param opts table
---@return string Group name
function vim.syn.keyword(group_name, keywords, opts)
  local command = { 'syn', 'keyword', group_name }

  for _, opt in ipairs(opts) do
    table.insert(command, opt)
  end
  for key, val in pairs(opts) do
    table.insert(command, string.format('%s=%s', key, val))
  end

  command = table.extends(command, keywords)

  vim.cmd(table.concat(command, ' '))

  return group_name
end
