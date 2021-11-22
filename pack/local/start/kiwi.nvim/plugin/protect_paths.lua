local PROTECT_PATHS = {
  '~/.rustup/toolchains',
  '~/.cargo/git',
}
PROTECT_PATHS = table.map(PROTECT_PATHS, vim.fn.expand)

local function on_read_post()
  local path = vim.fn.expand('%:p')

  for _, prefix in ipairs(PROTECT_PATHS) do
    if string.match(path, prefix) ~= nil then
      vim.bo.readonly = true
      vim.bo.modifiable = false

      return
    end
  end
end

vim.augroup('kiwi:protect_paths', function()
  vim.autocmd({ 'BufReadPost' }, '*', on_read_post)
end)
