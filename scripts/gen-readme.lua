local liluat = require('liluat')

local README_TEMPLATE = [[
# nvim-config

![My beautiful config](./.assets/screenshot.jpg)

## Plugins
{{ for _, group_name in ipairs(group_keys) do }}

### {{= GROUP_NAMES[group_name]}}

{{ for _, plugin in ipairs(groups[group_name]) do }}
- [{{= plugin.short_name}}](https://{{= plugin.git_host}}/{{= plugin.plugin_path or plugin.path}})
{{ end }}
{{ end }}
]]
local template = liluat.compile(README_TEMPLATE)

local DEFAULT_GROUP = 'uncategorized'
local GROUP_NAMES = {
  [DEFAULT_GROUP] = 'Uncategorized',
  ['deps'] = 'Third-party dependencies',
  ['ui'] = 'UI',
  ['colorscheme'] = 'Colorscheme',
  ['utils'] = 'Utilities',
  ['helpers'] = 'Helpers',
  ['syntax'] = 'Syntax / Languages',
  ['misc'] = 'Misc',
}

local packer = require('rc.plugins')

local plugins = nil
packer.set_handler('name', function(plugins_table, _, _)
  plugins = plugins_table
end)

packer.__manage_all()

local groups = {}
for _, plugin in pairs(plugins) do
  if plugin.disable then
    goto continue
  end

  local group_name = plugin.group or DEFAULT_GROUP
  if plugin.from_requires then
    group_name = 'deps'
  end

  if plugin.git_host == nil then
    plugin.git_host = 'github.com'
  end

  if GROUP_NAMES[group_name] == nil then
    error("Unknown group name: " .. group_name)
  end

  groups[group_name] = groups[group_name] or {}
  table.insert(groups[group_name], plugin)

  ::continue::
end

local function plugin_compare(lhs, rhs)
  return string.lower(lhs.short_name) < string.lower(rhs.short_name)
end
for _, group_plugins in pairs(groups) do
  table.sort(group_plugins, plugin_compare)
end

local last_keys = { DEFAULT_GROUP, 'deps' }
local group_keys = {}
for key, _ in pairs(groups) do
  if not table.contains(last_keys, key) then
    table.insert(group_keys, key)
  end
end
table.sort(group_keys)
for _, key in ipairs(last_keys) do
  if groups[key] ~= nil then
    table.insert(group_keys, key)
  end
end

local template_data = {
  GROUP_NAMES = GROUP_NAMES,
  groups = groups,
  group_keys = group_keys,
}

local file = io.open('README.md', 'w+')
file:write(liluat.render(template, template_data))
file:close()
