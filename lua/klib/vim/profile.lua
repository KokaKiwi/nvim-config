vim.profile = {}

function vim.profile.start(filename, opts)
  filename = filename or 'profile.log'
  opts = opts or {}

  local mode = '10,i1,s,m0'
  if opts.flame then
    mode = mode .. ',G'
  end

  if opts.autostop then
    vim.api.nvim_create_autocmd('VimLeave', {
      callback = function()
        vim.profile.stop()
      end,
    })
  end

  require('jit.p').start(mode, filename)
end

function vim.profile.stop()
  require('jit.p').stop()
end

function vim.profile.profile(filename, opts)
  opts = opts or {}
  opts.autostop = false

  return function(fun, ...)
    vim.profile.start(filename, opts)
    local _, ret = pcall(fun, ...)
    vim.profile.stop()

    return ret
  end
end

local profile_file_path = os.getenv('NVIM_PROFILE')
if profile_file_path ~= nil then
  if profile_file_path == '1' then
    profile_file_path = 'profile.log'
  elseif profile_file_path == '2' then
    profile_file_path = vim.fn.stdpath('log') .. '/profile.log'
  end

  local profile_flame = os.getenv('NVIM_PROFILE_FLAME') ~= '0'

  vim.profile.start(profile_file_path, { flame = profile_flame, autostop = true })
end
