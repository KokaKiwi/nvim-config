local logos_basedir = string.format('%s/local/kiwi.nvim/assets/dashboard/logos', vim.fn.stdpath('config'))

---@return string
return function()
  local logo_filenames = table.map(fs.readdir(logos_basedir), function(entry)
    return entry.name
  end)
  local logo_filename = math.randomchoice(logo_filenames)
  local logo_file = string.format('%s/%s', logos_basedir, logo_filename)
  local logo = fs.readfile(logo_file, {})

  return logo
end
