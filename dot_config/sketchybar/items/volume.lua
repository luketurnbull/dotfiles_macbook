local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local sbar = require("sketchybar")

local volume = sbar.add("item", "volume", {
	position = "right",
	icon = {
		string = icons.volume._0,
		color = colors.blue,
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
	padding_right = settings.pill_gap,
})

volume:subscribe("volume_change", function(env)
	local v = tonumber(env.INFO) or 0
	local icon
	if v >= 60 then
		icon = icons.volume._100
	elseif v >= 30 then
		icon = icons.volume._66
	elseif v > 0 then
		icon = icons.volume._33
	else
		icon = icons.volume._0
	end
	volume:set({
		icon = { string = icon },
		label = { string = v .. "%" },
	})
end)
