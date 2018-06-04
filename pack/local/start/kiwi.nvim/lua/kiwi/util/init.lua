local socket = require 'socket'

local util = {}

function util.sleep(duration)
  socket.select(nil, nil, duration)
end

return util
