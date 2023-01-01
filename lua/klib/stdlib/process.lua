_G.process = {}

function process.check_output(cmd)
  cmd = table.concat(cmd, ' ')

  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*all'))
  f:close()

  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')

  return s
end
