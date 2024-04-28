vim.o.background = 'dark'

vim.o.tabpagemax = 15
vim.o.showmode = false
vim.o.cursorline = false
vim.o.termguicolors = true

vim.o.backspace = string.join(',', { 'indent', 'eol', 'start' })
vim.o.linespace = 0
vim.o.number = true
vim.o.showmatch = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.winminheight = 0
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wildmenu = true
vim.o.wildmode = 'list:longest,full'
vim.o.whichwrap = string.join(',', { 'b', 's', 'h', 'l', '<', '>', '[', ']' })
vim.o.virtualedit = 'onemore'
vim.o.scrolljump = 5
vim.o.scrolloff = 3
vim.o.foldenable = false
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.signcolumn = 'yes:1'
vim.o.redrawtime = 10000

vim.g.tex_flavor = 'latex'

vim.g.do_filetype_lua = 1

vim.g.catppuccin_flavour = 'mocha'
