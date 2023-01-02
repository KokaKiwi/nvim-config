local M = {}

function M.hack_lazy()
  -- Hack diffview
  local diff_view = require('lazy.view.diff')

  diff_view.handlers['diffview.nvim'] = function(plugin, diff)
    local diffview = require('diffview')

    local path_arg = string.format('-C=%s', plugin.dir)

    if diff.commit then
      diffview.open(path_arg, diff.commit)
    else
      diffview.open(path_arg, string.format('%s..%s', diff.from, diff.to))
    end
  end
end

return M
