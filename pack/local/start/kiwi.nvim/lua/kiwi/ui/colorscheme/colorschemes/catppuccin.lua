return {
  palette = function(cp)
    return {
      rosewater = "#F5E0DC", -- Rosewater
      flamingo = "#F2CDCD", -- Flamingo
      mauve = "#DDB6F2", -- Mauve
      pink = "#F5C2E7", -- Pink
      red = "#F28FAD", -- Red
      maroon = "#E8A2AF", -- Maroon
      peach = "#F8BD96", -- Peach
      yellow = "#FAE3B0", -- Yellow
      green = "#ABE9B3", -- Green
      blue = "#96CDFB", -- Blue
      sky = "#89DCEB", -- Sky
      teal = "#B5E8E0", -- Teal
      lavender = "#C9CBFF", -- Lavender
      white = "#D9E0EE", -- White
      gray2 = "#C3BAC6", -- Gray2
      gray1 = "#988BA2", -- Gray1
      gray0 = "#6E6C7E", -- Gray0
      black4 = "#575268", -- Black4
      black3 = "#302D41", -- Black3
      black2 = "#1E1E2E", -- Black2
      black1 = "#1A1826", -- Black1
      black0 = "#161320", -- Black0
    }
  end,
  highlights = function(cp)
    return {
      base = {
        diffAdded = { fg = cp.green },
        diffRemoved = { fg = cp.red },
        diffChanged = { fg = cp.yellow },
        diffOldFile = { fg = cp.yellow },
        diffNewFile = { fg = cp.peach },
        diffFile = { fg = cp.blue },
        diffLine = { fg = cp.gray0 },
        diffIndexLine = { fg = cp.pink },
        DiffAdd = { fg = cp.green, bg = cp.black2 },
        DiffChange = { fg = cp.yellow, bg = cp.black2 },
        DiffDelete = { fg = cp.red, bg = cp.black2 },
        DiffText = { fg = cp.blue, bg = cp.black2 },
      },
    }
  end,
}
