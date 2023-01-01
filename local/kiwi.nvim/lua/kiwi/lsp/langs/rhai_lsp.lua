local util = require('lspconfig.util')

return {
  default_config = {
    cmd = { 'rhai-lsp', 'lsp', 'stdio' },
    filetypes = { 'rhai' },
    root_dir = function(fname)
      return util.find_git_ancestor(fname) or vim.loop.os_homedir()
    end,
    settings = {},
    init_options = {},
  },
  docs = {},
}
