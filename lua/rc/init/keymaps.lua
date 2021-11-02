local nkey = require('nkey')

nkey.setup {
  integrations = { 'which_key' },
}

nkey.register {
  -- Utils
  { '<Leader><Leader>s', nkey.Cmd('syntax', 'sync', 'fromstart'), options = { silent = false } },

  -- LSP
  { 'K',      vim.lsp.buf.hover },
  { 'gD',     vim.lsp.buf.implementation },
  { '<C-K>',  vim.lsp.buf.signature_help },
  { 'gr',     vim.lsp.buf.references, help = 'Find references [LSP]' },

  -- Tabs
  { '<C-', {
      { 't>', nkey.Cmd 'tabnew' },
      { 'x>', nkey.Cmd 'bwipe' },
  } },

  -- neosnippet
  { '<C-', {
      { 'k>', nkey.Plug 'neosnippet_expand_or_jump', mode = { 'i', 's' } },
      { 'k>', nkey.Plug 'neosnippet_expand_target',  mode = 'x' },
  } },

  -- UndoTree
  { '<C-u>', nkey.Cmd 'UndotreeToggle' },

  -- AeroJump
  { '<Leader>', {
      { 'aa', nkey.Plug 'AerojumpFromCursorBolt' },
      { 'ab', nkey.Plug 'AerojumpBolt' },
      { 'ad', nkey.Plug 'AerojumpDefault' },
      { 'as', nkey.Plug 'AerojumpSpace' },
  } },

  -- Trouble
  { '<Leader>t', nkey.Cmd 'TroubleToggle' },

  -- code-action-menu
  { 'com', nkey.Cmd 'CodeActionMenu', help = 'Code Action Menu' },

  -- nvim-tree
  { '<C-e>', nkey.Cmd 'NvimTreeToggle', help = 'Open file tree' },
}
