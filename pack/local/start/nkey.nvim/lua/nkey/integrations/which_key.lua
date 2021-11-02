local Integration = require('nkey.integration')
local wk = require('which-key')

local function register_keymap(mode, prefix, spec, preset, make_mapping)
  local help = spec.help
  if type(help) == 'string' then
    help = { desc = help }
  end

  local buffer = preset.buffer
  if buffer == true then
    buffer = 0
  end

  local opts = {
    mode = mode,
    buffer = buffer,
  }

  local mappings = {
    [prefix] = make_mapping(help),
  }

  wk.register(mappings, opts)
end

local function on_group(modes, prefix, spec, preset)
  if spec.help == nil then
    return
  end

  for _, mode in ipairs(modes) do
    register_keymap(mode, prefix, spec, preset, function(help)
      return { name = help.desc }
    end)
  end
end

local function on_map(modes, prefix, _, spec, preset)
  if spec.help == nil then
    return
  end

  for _, mode in ipairs(modes) do
    register_keymap(mode, prefix, spec, preset, function(help)
      return { help.desc }
    end)
  end
end

---@param nkey NKey
return Integration.new(function(nkey)
  nkey.hooks.on_map:register(on_map)
  nkey.hooks.on_group:register(on_group)
end)
