return function()
  local nougat = {
    core = require('nougat.core'),
    bar_util = require('nougat.bar.util'),
    sep = require('nougat.separator'),

    nut = {
      buf = {
        diagnostic_count = require('nougat.nut.buf.diagnostic_count').create,
        filename = require('nougat.nut.buf.filename').create,
        filestatus = require('nougat.nut.buf.filestatus').create,
        filetype = require('nougat.nut.buf.filetype').create,
      },
      git = {
        branch = require('nougat.nut.git.branch').create,
        status = require('nougat.nut.git.status'),
      },
      mode = require('nougat.nut.mode').create,
      ruler = require('nougat.nut.ruler').create,
      spacer = require('nougat.nut.spacer').create,
      truncation_point = require('nougat.nut.truncation_point').create,
    },

    Bar = require('nougat.bar'),
    Item = require('nougat.item'),
  }
end
