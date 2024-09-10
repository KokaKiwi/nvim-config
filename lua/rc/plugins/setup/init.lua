local M = {}

function M.setup_better_whitespace()
  prefixed(vim.g, 'better_whitespace') {
    filetypes_blacklist = {
      'dashboard', 'neo-tree', 'lazy', 'alpha',
      'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive',
    },
  }
end

function M.setup_colorizer()
  require('colorizer').setup({
    'css', 'lua', 'vim',
    css = { css = true },
  }, {
    rgb_fn = true,
    hsl_fn = true,
  })
end

function M.setup_committia()
  prefixed(vim.g, 'committia') {
    open_only_vim_starting = 0,
    edit_window_width = 120,
  }
end

function M.setup_crates()
  local crates = require('crates')
  crates.setup {
    null_ls = {
      enabled = false,
      name = "crates.nvim",
    },
  }
  crates.show()

  require('cmp').setup.buffer {
    sources = {
      { name = 'crates' },
    },
  }
end

function M.setup_ctrlp()
  prefixed(vim.g, 'ctrlp') {
    custom_ignore = {
      dir = '\\v[\\/](target|node_modules|_build)$',
    },
  }
end

function M.setup_gnupg()
  vim.g.GPGDefaultRecipients = { 'kokakiwi@kokakiwi.net' }
end

function M.setup_illuminate()
  prefixed(vim.g, 'Illuminate') {
    ftblacklist = { 'neo-tree' },
  }
end

function M.setup_lean()
  require('lean').setup {}
end

function M.setup_lint()
  local lint = require('lint')

  lint.linters_by_ft = {
    sh = { 'shellcheck' },
  }

  vim.api.nvim_create_autocmd('BufWritePost', {
    callback = function()
      lint.try_lint()
    end,
  })
end

function M.setup_marks()
  require('marks').setup {}
end

function M.setup_meadow()
  require('meadow').setup {}
end

function M.setup_shade()
  require('shade').setup {}
end

function M.setup_todo_comments()
  require('todo-comments').setup {}
end

function M.setup_undotree()
  prefixed(vim.g, 'undotree') {
    SetFocusWhenToggle = true,
  }
end

return M
