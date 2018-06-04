vim.opt.background = 'dark'

vim.opt.tabpagemax = 15
vim.opt.showmode = true
vim.opt.cursorline = false
vim.opt.termguicolors = true

vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.opt.linespace = 0
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.winminheight = 0
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildmenu = true
vim.opt.wildmode = { list = 'longest', 'full' }
vim.opt.whichwrap = string.join(',', { 'b', 's', 'h', 'l', '<', '>', '[', ']' })
vim.opt.virtualedit = 'onemore'
vim.opt.scrolljump = 5
vim.opt.scrolloff = 3
vim.opt.foldenable = false
vim.opt.shortmess:append('c')
vim.opt.signcolumn = 'number'

vim.g.tex_flavor = 'latex'
vim.g.mapleader = ','
vim.g.maplocalleader = ';'
