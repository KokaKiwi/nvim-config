local logos_basedir = string.format('%s/local/kiwi.nvim/assets/dashboard/logos', vim.fn.stdpath('config'))

local function get_logos()
  local ascii = require('ascii')

  local logo_files = table.map(fs.readdir(logos_basedir), function(entry)
    return { 'file', entry.name }
  end)

  local logo_texts = {}
  table.extends(logo_texts, {
    ascii.art.animals.cats.cookie,
    ascii.art.animals.cats.kitkat,
    ascii.art.animals.cats.mittens,
    ascii.art.animals.cats.pouncy,
  })
  table.dextends(logo_texts, ascii.art.animals.pandas)
  table.dextends(logo_texts, ascii.art.gaming.doom)
  table.dextends(logo_texts, ascii.art.gaming.pacman)
  table.dextends(logo_texts, ascii.art.gaming.undertale)
  table.dextends(logo_texts, ascii.art.misc.hydra)
  table.dextends(logo_texts, ascii.art.misc.skulls)
  table.dextends(logo_texts, ascii.art.text.neovim)

  logo_texts = table.map(logo_texts, function(text)
    return { 'text', text }
  end)

  return table.fjoin({
    logo_files,
    logo_texts,
  })
end

---@return string
return function()
  local logo_text = nil

  local logos = get_logos()
  local logo = math.randomchoice(logos)
  if logo[1] == 'file' then
    local logo_file = string.format('%s/%s', logos_basedir, logo[2])
    logo_text = fs.readfile(logo_file, {})
  elseif logo[1] == 'text' then
    logo_text = logo[2]
  end

  return logo_text
end
