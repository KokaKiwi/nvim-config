if os.getenv('NVIM_DEBUG') ~= '1' then
  local ok, impatient = pcall(require, 'impatient')
  if ok then impatient.enable_profile() end
end

-- Set a base colorscheme so that in case something goes wrong
-- neovim won't destroy my eyes with its default colorscheme.
vim.cmd.colorscheme('uwu')

require('rc')
