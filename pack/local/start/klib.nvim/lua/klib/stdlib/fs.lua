---@diagnostic disable: duplicate-doc-class
_G.fs = {}

---@class DirEntry

---@param path string
---@return DirEntry[]
function fs.readdir(path)
  local dir = vim.loop.fs_opendir(path, nil, 100)
  local entries = dir:readdir()
  dir:closedir()

  return entries
end

---@param path string
---@param dest string[] | nil
---@return string | string[]
function fs.readfile(path, dest)
  local file = assert(io.open(path, 'r'))

  local result
  if dest ~= nil then
    for line in file:lines() do
      table.insert(dest, line)
    end

    result = dest
  else
    result = file:read('*all')
  end

  file:close()

  return result
end

---@param path string
---@return boolean
function fs.is_executable(path)
  return vim.fn.executable(path) == 1
end
