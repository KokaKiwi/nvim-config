local Hook = require('hook')

---@class NKey
local nkey = {}

nkey.config = {
  defaults = {
    mode = 'n',
    buffer = false,
    prefix = '',
    options = {
      noremap = true,
      silent = true,
    },
  },
  integrations = {},
}
nkey.callbacks = {}
nkey.hooks = {
  ---@param modes string[]
  ---@param prefix string
  ---@param rhs string | function
  ---@param spec table
  ---@param preset table
  on_map = Hook.new(),
  ---@param modes string[]
  ---@param prefix string
  ---@param spec table
  ---@param preset table
  on_unmap = Hook.new(),
  ---@param modes string[]
  ---@param prefix string
  ---@param spec table
  ---@param preset table
  on_group = Hook.new(),
}

local OPTIONS_KEYS = table.keys(nkey.config.defaults)

---@param opts any table
function nkey.setup(opts)
  nkey.config = vim.tbl_deep_extend('force', nkey.config, opts)

  for _, integration in ipairs(nkey.config.integrations) do
    if type(integration) == 'string' then
      integration = require('nkey.integrations.' .. integration)
    end

    integration:setup(nkey)
  end
end

---@param cb function
---@param expr boolean | nil
---@return string
local function register_callback(cb, expr)
  if expr then
    local _cb = cb
    cb = function()
      local keys = _cb()
      return vim.api.nvim_replace_termcodes(keys, true, true, true)
    end
  end

  table.insert(nkey.callbacks, cb)

  local index = #nkey.callbacks
  local value = string.format('package.loaded.nkey.callbacks[%i]', index)

  if expr then
    return string.format('v:lua.%s()', value)
  else
    return string.format('<Cmd>lua %s()<CR>', value)
  end
end

---@param lhs table
---@param rhs table
---@return table
local function merge_spec(lhs, rhs)
  local result = table.copy(lhs)
  result = vim.tbl_deep_extend('force', result, table.filterkeys(rhs, OPTIONS_KEYS))

  if rhs.prefix ~= nil then
    if lhs.prefix ~= nil then
      result.prefix = lhs.prefix
    end
    result.prefix = lhs.prefix .. rhs.prefix
  end

  return result
end

---@param spec table
---@param preset table | nil
function nkey.register(spec, preset)
  preset = merge_spec(nkey.config.defaults, preset or {})
  preset = merge_spec(preset, spec)

  if #spec == 0 then
    return
  end
  if type(spec[1]) == 'table' then
    for _, item in ipairs(spec) do
      nkey.register(item, preset)
    end

    return
  end
  local prefix = preset.prefix .. spec[1]

  local modes = preset.mode
  if type(modes) == 'string' then
    modes = { modes }
  end

  local rhs = spec[2]
  if type(rhs) == 'table' then
    preset.prefix = prefix
    nkey.register(rhs, preset)

    nkey.hooks.on_group:run(modes, preset.prefix, spec, preset)

    return
  end
  if type(rhs) == 'function' then
    rhs = register_callback(rhs, preset.options.expr)
  end

  if rhs ~= nil then
    for _, mode in ipairs(modes) do
      if preset.buffer then
        local buffer = preset.buffer
        if buffer == true then
          buffer = 0
        end

        if rhs == 'none' then
          vim.api.nvim_buf_del_keymap(buffer, mode, prefix)
        else
          vim.api.nvim_buf_set_keymap(buffer, mode, prefix, rhs, preset.options)
        end
      else
        if rhs == 'none' then
          vim.api.nvim_del_keymap(mode, prefix)
        else
          vim.api.nvim_set_keymap(mode, prefix, rhs, preset.options)
        end
      end
    end
  end

  if rhs == 'none' then
    nkey.hooks.on_unmap:run(modes, prefix, spec, preset)
  else
    nkey.hooks.on_map:run(modes, prefix, spec[2], spec, preset)
  end
end

---@param name string
---@return string
function nkey.Cmd(name, ...)
  local command = table.concat({ name, ... }, ' ')
  return string.format('<Cmd>%s<CR>', command)
end

---@param name string
---@return string
function nkey.Plug(name)
  return string.format('<Plug>(%s)', name)
end

return nkey
