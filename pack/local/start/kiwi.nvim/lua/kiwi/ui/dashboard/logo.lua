local logos_basedir = string.format('%s/pack/local/start/kiwi.nvim/assets/dashboard/logos', vim.fn.stdpath('config'))

---@return string
return function()
  local logos_files = table.map(fs.readdir(logos_basedir), function(entry)
    return string.format('%s/%s', logos_basedir, entry.name)
  end)
  local logo_file = math.randomchoice(logos_files)
  local logo = fs.readfile(logo_file, {})

  return logo
end
