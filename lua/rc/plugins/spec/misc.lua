local util = require('rc.plugins.util')

return util.module('misc', function(use)
  use { 'vim-denops/denops.vim',
    cond = util.cond.is_executable('deno'),
  }

  use { 'ryoppippi/bad-apple.vim',
    dependencies = { 'denops.vim' },
    cond = util.cond.is_executable('deno'),
  }
end)
