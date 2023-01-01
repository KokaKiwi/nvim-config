---@param events string | string[]
---@param pattern string | string[]
---@param cmd string | function
---@param opts table
function vim.autocmd(events, pattern, cmd, opts)
  opts = opts or {}

  local options = {
    pattern = pattern,

    group = opts.group,
    once = opts.once,
    nested = opts.nested,
    desc = opts.desc,
  }

  if type(cmd) == 'function' then
    options.callback = function() cmd() end
  else
    options.command = cmd
  end

  vim.api.nvim_create_autocmd(events, options)
end

---@param filetype string | string[]
---@param cmd string | function
---@param opts table
function vim.aufiletype(filetype, cmd, opts)
  vim.autocmd('FileType', filetype, cmd, opts)
end

---@param pattern string | string[]
---@param cmd string | function | table
---@param opts table
function vim.aubufread(pattern, cmd, opts)
  if type(cmd) == 'table' then
    opts = cmd

    local opt = vim.tbl_extend('force', {}, opts.opt)

    cmd = nil
    if opts.ft ~= nil then
      opt.ft = opts.ft
    end

    if vim.tbl_count(opt) == 1 and opts.ft ~= nil then
      cmd = string.format('setf %s', opt.ft)
    elseif vim.tbl_count(opt) > 0 then
      cmd = string.format('set %s', string.join(' ', table.dmap(opt, function(key, value)
        return string.format('%s=\'%s\'', key, value)
      end, true)))
    end
  end

  vim.autocmd({ 'BufRead', 'BufNewFile' }, pattern, cmd, opts)
end

vim.api.nvim_add_user_command = vim.api.nvim_create_user_command

---@param name string
---@param repl string | function
---@param opts table
function vim.command(name, repl, opts)
  opts = opts or {}

  local complete = opts.complete
  if type(complete) == 'table' then
    complete = function()
      return opts.complete
    end
  end

  local options = {
    range = opts.range,
    addr = opts.addr,
    nargs = opts.nargs or '*',

    complete = complete,
  }

  local callback = function(data)
    repl(unpack(data.fargs))
  end

  vim.api.nvim_add_user_command(name, callback, options)
end

-- vim.augroup
function vim.augroup(name, fn)
  vim.cmd(string.format('augroup %s', name))
  vim.cmd('autocmd!')

  pcall(fn)

  vim.cmd('augroup end')
end
