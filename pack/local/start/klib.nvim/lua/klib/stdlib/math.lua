math.randomseed(os.clock())

function math.randomchoice(t)
  local keys = {}
  for key, _ in pairs(t) do
    keys[#keys + 1] = key
  end

  local index = math.random(1, #keys)
  local key = keys[index]
  return t[key]
end
