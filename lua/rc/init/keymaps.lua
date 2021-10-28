---@diagnostic disable: unused-local
local nest = require('nest')
local wk = require('which-key')

function nest.Cmd(name, ...)
  local command = { name, ... }

  return string.format('<Cmd>%s<CR>', table.concat(command, ' '))
end
local Cmd = nest.Cmd

function nest.Plug(name)
  return string.format('<Plug>(%s)', name)
end
local Plug = nest.Plug

function nest.Plugr(name)
  return string.format('<Plug>%s', name)
end
local Plugr = nest.Plugr

nest.applyKeymaps {
  -- Utils
  { '<Leader><Leader>s', Cmd('syntax', 'sync', 'fromstart'), options = { silent = false } },

  -- LSP
  -- { '<C-]>',  vim.lsp.buf.definition },
  { 'K',      vim.lsp.buf.hover },
  { 'gD',     vim.lsp.buf.implementation },
  { '<C-K>',  vim.lsp.buf.signature_help },
  { 'gr',     vim.lsp.buf.references },

  -- Tabs
  { '<C-', {
      { 'PageDown>',  Cmd 'bnext' },
      { 'PageUp>',    Cmd 'bprev' },
      { 't>',         Cmd 'tabnew' },
      { 'x>',         Cmd 'bwipe' },
  } },

  -- neosnippet
  { '<C-', {
      { 'k>', Plug 'neosnippet_expand_or_jump', mode = 'i' },
      { 'k>', Plug 'neosnippet_expand_or_jump', mode = 's' },
      { 'k>', Plug 'neosnippet_expand_target',  mode = 'x' },
  } },

  -- vim-easy-align
  { 'ga', Plug 'EasyAlign' },
  { 'ga', Plug 'EasyAlign', mode = 'x' },

  -- UndoTree
  { '<C-u>', Cmd 'UndotreeToggle' },

  -- Vista.vim
  { '<S-t>', Cmd('Vista', 'focus') },

  -- AeroJump
  { '<Leader>', {
      { 'aa', Plug 'AerojumpFromCursorBolt' },
      { 'ab', Plug 'AerojumpBolt' },
      { 'ad', Plug 'AerojumpDefault' },
      { 'as', Plug 'AerojumpSpace' },
  } },

  -- Trouble
  { '<Leader>t', Cmd 'TroubleToggle' },

  -- code-action-menu
  { 'com', Cmd 'CodeActionMenu' },

  -- nvim-tree
  { '<C-e>', Cmd 'NvimTreeToggle' },
}
