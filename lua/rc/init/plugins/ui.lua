-- nvim-tree
vim.api.nvim_set_keymap('n', '<C-E>', ':NvimTreeToggle<CR>', { noremap = true })

prefixed(vim.g, 'nvim_tree') {
  auto_ignore_ft = { 'startify' },
  ignore = {
    '.git', '.hg', '.svn', '.bzr', '.pijul',
    '.pyc', '.pyd', '.egg-infos', '__pycache__',
    '.class',
    '.swp',
  },
  special_files = {
    ['README.md'] = 1,
    ['Makefile'] = 1,
    ['Justfile'] = 1,
  },
  quit_on_open = 1,
  show_icons = {
    git = 0,
    folders = 1,
    files = 1,
    folder_arrows = 1,
  },
  icons = {
    default = '',
    symlink = '',
    folder = {
      arrow_open = '',
      arrow_closed = '',
      default = '',
      open = '',
      empty = '',
      empty_open = '',
      symlink = '',
      symlink_open = '',
    },
  },
  group_empty = 1,
  add_trailing = 1,
  disable_window_picker = 1,
}

-- UndoTree
prefixed(vim.g, 'undotree') {
  SetFocusWhenToggle = true,
}

-- Vista.vim
prefixed(vim.g, 'vista') {
  default_executive = 'nvim_lsp',
  finder_alternative_executives = { 'ctags' },
  width = 40,
}
vim.g['vista#renderer#enable_icon'] = 1

-- CtrlP
prefixed(vim.g, 'ctrlp') {
  custom_ignore = {
    dir = '\\v[\\/](target|node_modules|_build)$',
  },
}

-- Startify
prefixed(vim.g, 'startify') {
  lists = {
    { type = 'files', header = { '  MRU' } }
  },

  fortune_use_unicode = true,
}

-- committia.vim
prefixed(vim.g, 'committia') {
  edit_window_width = 120,
  min_window_width = 240,
}

-- vim-illuminate
prefixed(vim.g, 'Illuminate') {
  ftblacklist = { 'NvimTree' },
}

-- sonokai
prefixed(vim.g, 'sonokai') {
  enable_italic = true,
  menu_selection_background = 'green',
  transparent_background = true,
}
