return function(cp)
  return {
    DashboardShortCut = { fg = cp.magenta },
    DashboardHeader = { fg = cp.heading.h2 },
    DashboardCenter = { fg = cp.green },
    DashboardFooter = { fg = cp.yellow, style = 'italic' },
  }
end
