local nkey = require('nkey')
local wk = require('which-key')

nkey.setup {
  integrations = { 'legendary', 'which_key' },
}

wk.setup {
  plugins = {
    presets = {
      operators = false,
    },
  },
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
  { 'g', {
    { 'd',  vim.lsp.buf.definition, help = 'Go to definition [LSP]' },
    { 'D',  vim.lsp.buf.declaration, help = 'Go to declaration [LSP]' },
    { 'I',  vim.lsp.buf.implementation, help = 'Go to implementation [LSP]' },
    { 'r',  vim.lsp.buf.references, help = 'Find references [LSP]' },
    { 'R',  vim.lsp.buf.rename, help = 'Rename symbol [LSP]' },
  } },

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
    { 'f', Telescope 'find_files', help = 'Find files' },
    { 'g', Telescope 'live_grep',  help = 'Live grep' },
    { 'h', Telescope 'help_tags',  help = 'Help tags' },
  }, help = '+telescope' },
  { '<Leader>T', nkey.Cmd 'Telescope' },

  -- Aerial
  { '<S-t>', nkey.Cmd 'AerialToggle', help = 'Open symbols outline' },

  -- doc
  { '<Leader>', {
    { 'k', help = 'Toggle variable highlight' },
    { 's', help = 'Strip whitespaces' },
  } },
  { '<C-p>', help = 'Find file' },
}
