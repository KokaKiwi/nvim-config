return function(cp)
  return {
    NvimTreeFolderName = { fg = cp.blue },
    NvimTreeFolderIcon = { fg = cp.blue },
    NvimTreeNormal = { fg = cp.fg, bg = cp.bg.base },
    NvimTreeOpenedFolderName = { fg = cp.blue },
    NvimTreeEmptyFolderName = { fg = cp.blue },
    NvimTreeIndentMarker = { fg = cp.syntax.marker },
    NvimTreeVertSplit = cp.hidden,
    NvimTreeRootFolder = { fg = cp.blue, style = 'bold' },
    NvimTreeSymlink = { fg = cp.magenta },
    NvimTreeStatuslineNc = cp.hidden,
    NvimTreeGitDirty = { fg = cp.yellow },
    NvimTreeGitNew = { fg = cp.blue },
    NvimTreeGitDeleted = { fg = cp.red },
    NvimTreeSpecialFile = { fg = cp.uri },
    NvimTreeImageFile = { fg = cp.white },
    NvimTreeOpenedFile = { fg = cp.pink },
  }
end
