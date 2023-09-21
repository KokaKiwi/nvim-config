local hack = require('rc.plugins.hack')

local util = {}

function util.require_lazy()
  local lazy_url = 'https://github.com/folke/lazy.nvim'
  local lazy_install_dir = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

  if not vim.loop.fs_stat(lazy_install_dir) then
    vim.fn.system({
      'git', 'clone',
      '--filter=blob:none', '--branch=stable',
      lazy_url,
      lazy_install_dir,
    })
  end

  vim.opt.rtp:prepend(lazy_install_dir)

  local lazy = require('lazy')
  hack.hack_lazy()
  return lazy
end

function util.module(group_name, init_fn)
  local plugins = {}

  local function use(spec)
    if type(spec) == 'string' then
      spec = { spec }
    end

    if spec.gitlab ~= nil and spec.gitlab ~= false then
      local gitlab_host = 'gitlab.com'
      if type(spec.gitlab) == 'string' then
        gitlab_host = spec.gitlab
      elseif spec.gitlab_host ~= nil then
        gitlab_host = spec.gitlab_host
      end
      spec.url = string.format('https://%s/%s', gitlab_host, spec.gitlab)
      spec.gitlab = nil
      spec.gitlab_host = nil
    end

    if spec['local'] ~= nil and spec['local'] ~= false then
      spec.dir = string.format('%s/local/%s', vim.fn.stdpath('config'), spec['local'])
      spec['local'] = nil
    end

    spec.group_name = group_name

    table.insert(plugins, spec)
  end

  init_fn(use)

  return plugins
end

util.cond = {
  is_executable = function(name)
    return vim.is_executable(name)
  end,
  has_module = function(name)
    local has_module, err = pcall(require, name)
    if not has_module and os.getenv('DEBUG') then
      print(err)
    end
    return has_module
  end,

  all = function(...)
    local conds = {...}

    for _, cond in ipairs(conds) do
      if type(cond) == 'functions' then
        cond = cond()
      end

      if not cond then
        return false
      end
    end

    return true
  end,
  any = function(...)
    local conds = {...}

    for _, cond in ipairs(conds) do
      if type(cond) == 'functions' then
        cond = cond()
      end

      if cond then
        return true
      end
    end

    return false
  end,
}

util.action = {
  call = function(name, ...)
    local args = {...}

    return function() vim.call(name, unpack(args)) end
  end,
  cmd = function(name, ...)
    local args = { ... }
    return function() vim.cmd { cmd = name, args = args } end
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
    cmd = function(...)
      local args = {...}
      return table.concat(args, ' ')
    end,
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
    return function()
      require(name)
    end
  end,
  mod_setup = function(name)
    return function(plugin, opts)
      require(name).setup(plugin, opts)
    end
  end,
  mod_call = function(name)
    return function(plugin, opts)
      require(name)(plugin, opts)
    end
  end,

  rc = function(name, submod)
    local modname = 'rc.plugins.setup'
    if submod ~= nil then
      modname = modname .. '.' .. submod
    end

    local mod = require(modname)
    local setup_name = string.format('setup_%s', name)

    return mod[setup_name]
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
