local M = {}

function M.setup_Comment()
  require('Comment').setup {
    toggler = {
      line = '<Leader>cc',
      block = '<Leader>bc',
    },
    opleader = {
      line = '<Leader>c',
      block = '<Leader>b',
    },
  }

  require('nkey').register {
    { '<Leader>', {
      { 'b', {
        { 'c', help = 'Toggle comment (blockwise)' },
      }, help = 'comment' },
      { 'c', {
        { 'c', help = 'Toggle comment (linewise)' },

        { 'A', ___comment_norm_A, help = 'Insert comment to end of the current line' },
        { 'o', ___comment_norm_o, help = 'Insert comment to the next line' },
        { 'O', ___comment_norm_O, help = 'Insert comment to the previous line' },
      }, help = 'comment' },
    }, mode = 'n' },
    { '<Leader>', {
      { 'c', help = 'Toggle comment (linewise)' },
      { 'b', help = 'Toggle comment (blockwise)' },
    }, mode = 'x' },

    -- Unmap default keymaps
    { 'gc', {
      { 'o', 'none' },
      { 'O', 'none' },
      { 'A', 'none' },
    }, mode = 'n' },
  }
end

function M.setup_neorg()
  require('neorg').setup {
    load = {
      ['core.defaults'] = {},
      ['core.norg.concealer'] = {},
      ['core.norg.dirman'] = {},
    },
  }
end

return M
