local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local sbar = require("sketchybar")

local clock = sbar.add("item", "clock", {
	position = "right",
	update_freq = 10,
	icon = {
		string = icons.clock,
		color = colors.magenta,
	},
	label = {
		color = colors.white,
	},
	background = {
		drawing = true,
		color = colors.bg2,
		corner_radius = settings.corner_radius,
		height = settings.item_height,
	},
})

clock:subscribe({ "routine", "forced" }, function()
	clock:set({ label = { string = os.date("%d/%m %H:%M") } })
end)
