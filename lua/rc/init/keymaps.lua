local nkey = require('nkey')
local wk = require('which-key')

local function Telescope(name)
  return nkey.Cmd('Telescope', name)
end

wk.setup {
  notify = false,
}

nkey.register {
  -- Utils
  { '<Leader><Leader>s', nkey.Cmd('syntax', 'sync', 'fromstart'),
    options = { silent = false },
    help = 'Reload syntax coloring',
  },

  -- LSP
  { 'g', {
    { 'd', help = 'Go to definition [LSP]' },
    { 'D', help = 'Go to declaration [LSP]' },
    { 'I', vim.lsp.buf.implementation,  help = 'Go to implementation [LSP]' },
    { 'r', vim.lsp.buf.references,      help = 'Find references [LSP]'},
  } },

  -- Tabs
  { '<C-', {
      { 't>', nkey.Cmd 'tabnew',  help = 'Open new tab' },
      { 'x>', nkey.Cmd 'bwipe',   help = 'Close tab' },
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
  { '<Leader>t', nkey.Cmd('Trouble', 'diagnostics', 'toggle') },

  -- neo-tree
  { '<C-d>', function()
      require('neo-tree.command').execute {
        action = 'focus',
        toggle = true,
      }
    end, help = 'Toggle File Tree' },
  { '<C-r>', function()
      require('neo-tree.command').execute {
        action = 'focus',
        source = 'remote',
        toggle = true,
      }
    end, help = 'Toggle Remote File Tree' },

  -- telescope.nvim
  { '<Leader>f', {
    { 'f', Telescope 'find_files', help = 'Find files' },
    { 'g', Telescope 'live_grep',  help = 'Live grep' },
    { 'h', Telescope 'help_tags',  help = 'Help tags' },
  }, help = '+telescope' },
  { '<Leader>T', nkey.Cmd 'Telescope' },

  -- Aerial
  { '<S-t>', nkey.Cmd 'AerialToggle', help = 'Open symbols outline' },

  -- nvim-various-textobjs
  { 'gX', {
    { '?', function()
        require('various-textobjs').diagnostic()
      end, help = 'Diagnostic TextObjects' },
  }, help = '+textobjs' },

  -- overseer
  { '<C-o>', function()
      require('overseer').toggle()
    end, help = 'Open Overseer tasks' },

  -- doc
  { '<Leader>', {
    { 'k', help = 'Toggle variable highlight' },
    { 's', help = 'Strip whitespaces' },
  } },
  { '<C-p>', help = 'Find file' },
}
