local info = debug.getinfo(1, 'S')
local module_directory = string.match(info.source, '^@(.*)/')
local module_filename = string.match(info.source, '/([^/]*)$')
local module_name = ...

for name, type in vim.fs.dir(module_directory) do
  if type == "file" and not (name == module_filename) then
    local config_module = string.match(name, "(.+).lua$")
    require(module_name .. "." .. config_module)
  end
end
