local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local sbar = require("sketchybar")

local battery = sbar.add("item", "battery", {
	position = "right",
	update_freq = 120,
	icon = {
		string = icons.battery._100,
		color = colors.green,
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

battery:subscribe({ "routine", "system_woke", "power_source_change", "forced" }, function()
	sbar.exec("pmset -g batt", function(batt_info)
		local pct = tonumber(batt_info:match("(%d+)%%")) or 0
		local charging = batt_info:find("AC Power") ~= nil

		local icon
		if pct >= 90 then
			icon = icons.battery._100
		elseif pct >= 60 then
			icon = icons.battery._75
		elseif pct >= 30 then
			icon = icons.battery._50
		elseif pct >= 10 then
			icon = icons.battery._25
		else
			icon = icons.battery._0
		end

		local color
		if charging then
			icon = icons.battery.charging
			color = colors.yellow
		elseif pct < 20 then
			color = colors.red
		else
			color = colors.green
		end

		battery:set({
			icon = { string = icon, color = color },
			label = { string = pct .. "%" },
		})
	end)
end)
