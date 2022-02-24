local util = {}

function util.require_packer()
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  local packer_install_dir = string.format('%s/site/pack/packer/start', vim.fn.stdpath('data'))
  local bootstrap = false

  if not vim.loop.fs_stat(packer_install_dir) then
    vim.fn.mkdir(packer_install_dir, 'p')
    os.execute(string.format('git clone %s %s', packer_url, packer_install_dir .. '/packer.nvim'))

    bootstrap = true
  end

  vim.cmd [[packadd packer.nvim]]

  local packer = require('packer')
  packer._bootstrap = bootstrap
  return packer
end

-- https://github.com/wbthomason/packer.nvim/blob/963cb58c3dd15699c801baf3e64393c6795b62e9/lua/packer.lua#L184-L191
function util.plugin_name(plugin_spec)
  if type(plugin_spec) == 'string' then
    plugin_spec = { plugin_spec }
  end

  local path = vim.fn.expand(plugin_spec[1])
  local name_segments = vim.split(path, '/')
  local segment_index = #name_segments
  local name = plugin_spec.as or name_segments[segment_index]
  while name == '' and segment_index > 0 do
    name = name_segments[segment_index]
    segment_index = segment_index - 1
  end

  return name
end

util.cond = {
  is_executable = function(name)
    return string.format([[vim.fn.executable('%s') == 1]], name)
  end,

  all = function(...)
    local conds = {...}

    return table.concat(table.map(conds, func.partial(string.format, '(%s)')), ' and ')
  end,
  any = function(...)
    local conds = {...}

    return table.concat(table.map(conds, func.partial(string.format, '(%s)')), ' or ')
  end,
}

util.action = {
  call = function(name, ...)
    local args = {...}

    return function() vim.call(name, unpack(args)) end
  end,
  cmd = function(name, ...)
    local cmd = { name, ... }

    return function() vim.cmd(table.concat(cmd, ' ')) end
  end,
  all = function(...)
    local actions = {...}

    return function()
      for _, action in ipairs(actions) do
        action()
      end
    end
  end,
  shell = {
    make = function(path)
      local command = { 'make' }
      if path ~= nil then
        table.extends(command, { '-C', path })
      end

      return table.concat(command, ' ')
    end,
  },
}

util.setup = {
  mod = function(name)
    return string.format([[require('%s')]], name)
  end,
  mod_setup = function(name)
    return string.format([[require('%s').setup()]], name)
  end,
  mod_call = function(name)
    return string.format([[require('%s')()]], name)
  end,
  ---@param name string
  ---@param modname string
  ---@return string
  rc = function(name, modname)
    local fullmodname = 'rc.plugins.setup'
    if modname ~= nil then
      fullmodname = string.format('%s.%s', fullmodname, modname)
    end

    return string.format([[require('%s').setup_%s()]], fullmodname, name)
  end,
  rc_mod = function(name)
    return util.setup.mod(string.format('rc.plugins.setup.%s', name))
  end,
  rc_mod_setup = function(name)
    return util.setup.mod_setup(string.format('rc.plugins.setup.%s', name))
  end,
  rc_mod_call = function(name)
    return util.setup.mod_call(string.format('rc.plugins.setup.%s', name))
  end,
}

return util
