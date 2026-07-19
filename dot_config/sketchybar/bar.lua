local colors = require("colors")
local settings = require("settings")
local sbar = require("sketchybar")

sbar.bar({
	position = "top",
	height = settings.bar_height,
	blur_radius = 30,
	color = colors.bar.bg,
	border_width = 0,
	border_color = colors.bar.border,
	margin = 0,
	padding_left = 15,
	padding_right = 10,

	corner_radius = 0,
	y_offset = 0,
	topmost = "window",
	sticky = "on",
})
