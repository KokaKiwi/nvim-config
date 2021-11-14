local M = {}

function M.setup_headlines()
  require('headlines').setup {}
end

function M.setup_treesitter()
  require('nvim-treesitter.configs').setup {
    ensure_installed = 'maintained',
    highlight = {
      enable = true,
    },
    playground = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
    },
  }

  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end

return M
