local M = {}

_G.dashboard_actions = {}

function M.button(opts)
  local shortcut = opts[1]
  local text = opts[2]
  local on_press = opts[3]

  local shortcut_text = shortcut
  local keymap = shortcut
  if type(shortcut) == 'table' then
    shortcut_text = shortcut[1]
    keymap = shortcut[2]
  end

  local keymap_action = on_press
  if type(keymap_action) == 'function' then
    local action_index = #dashboard_actions + 1
    dashboard_actions[action_index] = keymap_action
    keymap_action = string.format('<Cmd>lua dashboard_actions[%i]()<CR>', action_index)
  end

  return {
    type = 'button',
    val = text,
    on_press = on_press,
    opts = {
      position = 'center',
      cursor = opts.cursor or 0,
      width = opts.width or 50,
      hl = opts.hl or 'DashboardCenter',

      shortcut = shortcut_text,
      align_shortcut = 'right',
      hl_shortcut = opts.hl_shortcut or 'DashboardShortCut',

      keymap = {
        'n', keymap, keymap_action,
        { noremap = true, silent = true, nowait = true }
      },
    },
  }
end

function M.text(text, opts)
  opts = opts or {}
  if type(text) == 'table' then
    opts = text
    text = opts[1]
  end

  opts.position = opts.posiiton or 'center'

  return {
    type = 'text',
    val = text,
    opts = opts,
  }
end

function M.info(text)
  return M.text { text,
    hl = 'NonText',
  }
end

M.action = {
  cmd = function(cmd)
    return function() vim.cmd(cmd) end
  end,
}

return M
