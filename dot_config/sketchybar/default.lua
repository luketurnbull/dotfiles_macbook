local colors = require("colors")
local settings = require("settings")
local sbar = require("sketchybar")

sbar.default({
	updates = "when_shown",
	icon = {
		font = {
			family = settings.font.icons,
			style = settings.font.style_map["Bold"],
			size = 17.0,
		},
		color = colors.white,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
	},
	label = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = 14.0,
		},
		color = colors.white,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
	},
	background = {
		height = settings.item_height,
		corner_radius = settings.corner_radius,
		border_width = 0,
		drawing = false,
	},
	scroll_texts = true,
})
