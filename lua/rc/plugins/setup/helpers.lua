local M = {}

function M.setup_headlines()
  require('headlines').setup {}
end

function M.setup_rust_tools()
  require('rust-tools').setup {
    tools = {
      hover_with_actions = false,
      inlay_hints = {
        other_hints_prefix = '» ',
        highlight = 'NonText',
      },
    },

    server = {
      settings = {
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true,
          },
          checkOnSave = {
            command = 'clippy',
          },
        },
      },
    },
  }
end

function M.setup_snippy()
  require('snippy').setup {}
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
