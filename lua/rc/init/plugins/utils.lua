-- GnuPG
vim.g.GPGDefaultRecipients = { 'kokakiwi@kokakiwi.net' }

-- vim-better-whitespace
prefixed(vim.g, 'better_whitespace') {
  filetypes_blacklist = {
    'dashboard', 'NvimTree',
    'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive',
  },
}

-- Glow
prefixed(vim.g, 'glow') {
  binary_path = '/usr/bin',
}
