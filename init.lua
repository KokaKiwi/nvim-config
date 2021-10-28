local ok, impatient = pcall(require, 'impatient')
if ok then impatient.enable_profile() end

-- Set a base colorscheme so that in case something goes wrong
-- neovim doesn't destroy my eyes with its default colorscheme.
vim.cmd [[colorscheme vimdark]]

require('rc')
