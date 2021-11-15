local nkey = require('nkey')

nkey.setup {
  integrations = { 'which_key' },
}

local function Telescope(name)
  return nkey.Cmd('Telescope', name)
end

nkey.register {
  -- Utils
  { '<Leader><Leader>s', nkey.Cmd('syntax', 'sync', 'fromstart'),
    options = { silent = false },
    help = 'Reload syntax coloring',
  },

  -- LSP
  { 'gd',     vim.lsp.buf.definition, help = 'Go to definition [LSP]' },
  { 'gD',     vim.lsp.buf.declaration, help = 'Go to declaration [LSP]' },
  { 'gI',     vim.lsp.buf.implementation, help = 'Go to implementation [LSP]' },
  { 'gr',     vim.lsp.buf.references, help = 'Find references [LSP]' },

  -- Tabs
  { '<C-', {
      { 't>', nkey.Cmd 'tabnew', help = 'Open new tab' },
      { 'x>', nkey.Cmd 'bwipe', help = 'Close tab' },
  } },

  -- neosnippet
  { '<C-', {
      { 'k>', nkey.Plug 'neosnippet_expand_or_jump', mode = { 'i', 's' } },
      { 'k>', nkey.Plug 'neosnippet_expand_target',  mode = 'x' },
  } },

  -- UndoTree
  { '<C-u>', nkey.Cmd 'UndotreeToggle', help = 'Toggle Undo tree' },

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

  -- telescope.nvim
  { '<Leader>f', {
    { 'e', Telescope 'file_browser', help = 'File explorer' },
    { 'f', Telescope 'find_files', help = 'Find files' },
    { 'g', Telescope 'live_grep',  help = 'Live grep' },
    { 'h', Telescope 'help_tags',  help = 'Help tags' },
  }, help = '+telescope' },
  { '<Leader>T', nkey.Cmd 'Telescope' },

  -- symbols-outline
  { '<S-t>', nkey.Cmd 'SymbolsOutline', help = 'Open Symbols Outline' },

  -- doc
  { '<Leader>', {
    { 'k', help = 'Toggle variable highlight' },
    { 's', help = 'Strip whitespaces' },
  } },
  { '<C-p>', help = 'Find file' },
}
