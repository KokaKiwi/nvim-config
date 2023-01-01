if vim.b.current_syntax ~= nil then
  return
end

vim.syn.case('match')

vim.cmd([[
syntax sync fromstart
setlocal iskeyword+=-
]])

vim.b.current_syntax = 'systemd'
