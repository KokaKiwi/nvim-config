local liluat = require('liluat')

local README_TEMPLATE = [[
# nvim-config

## Plugins
{{ for _, group_name in ipairs(group_keys) do }}

### {{= GROUP_NAMES[group_name]}}

{{ for _, plugin in ipairs(groups[group_name]) do }}
- [{{= plugin.name}}](https://github.com/{{= plugin.path}})
{{ end }}
{{ end }}
]]
local template = liluat.compile(README_TEMPLATE)

local DEFAULT_GROUP = 'uncategorized'
local GROUP_NAMES = {
  [DEFAULT_GROUP] = 'Uncategorized',
  ['ui'] = 'UI',
  ['colorscheme'] = 'Colorscheme',
  ['util'] = 'Utilities',
  ['helpers'] = 'Helpers',
  ['syntax'] = 'Syntax / Languages',
}

local packer = require('rc.plugins')

local plugins = nil
packer.set_handler('name', function(plugins_table, _, _)
  plugins = plugins_table
end)

packer.__manage_all()

local groups = {}
for _, plugin in pairs(plugins) do
  local group_name = plugin.group or DEFAULT_GROUP
  if GROUP_NAMES[group_name] == nil then
    error("Unknown group name: " .. group_name)
  end

  groups[group_name] = groups[group_name] or {}
  table.insert(groups[group_name], plugin)
end

local function plugin_compare(lhs, rhs)
  return string.lower(lhs.name) < string.lower(rhs.name)
end
for _, group_plugins in pairs(groups) do
  table.sort(group_plugins, plugin_compare)
end

local group_keys = {}
for key, _ in pairs(groups) do
  if key ~= DEFAULT_GROUP then
    table.insert(group_keys, key)
  end
end
table.sort(group_keys)
if groups[DEFAULT_GROUP] ~= nil then
  table.insert(group_keys, DEFAULT_GROUP)
end

local template_data = {
  GROUP_NAMES = GROUP_NAMES,
  groups = groups,
  group_keys = group_keys,
}

local file = io.open('README.md', 'w+')
file:write(liluat.render(template, template_data))
file:close()
