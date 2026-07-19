-- Make `require("colors")` resolve to plugins/colors.lua, and let the SbarLua
-- C module be loadable by name.
local home = os.getenv("HOME")
local config_dir = home .. "/.config/sketchybar"

package.path = table.concat({
	config_dir .. "/?.lua",
	config_dir .. "/?/init.lua",
	config_dir .. "/plugins/?.lua",
	package.path,
}, ";")

package.cpath = table.concat({
	home .. "/.local/share/sketchybar_lua/?.so",
	package.cpath,
}, ";")

require("bar")
require("default")
require("items")

require("sketchybar").update()
