local colors = require("colors")
local settings = require("settings")
local app_icons = require("icon_map")
local sbar = require("sketchybar")

local NUM_WS = 9
local SLOTS_PER_WS = 8

local aliases = {
	["Zen"] = "Zen Browser",
}

local function glyph_for(app_name)
	local key = aliases[app_name] or app_name
	return app_icons[key] or app_icons["Default"] or "?"
end

local state = {
	focused_sid = "1",
	focused_wid = nil,
	wins_by_sid = {},
}

local last = {}
local function diff(name, key, value)
	local cur = last[name] or {}
	if cur[key] == value then
		return false
	end
	cur[key] = value
	last[name] = cur
	return true
end

local pills = {}

for n = 1, NUM_WS do
	local sid = tostring(n)

	local number = sbar.add("item", "ws." .. sid .. ".num", {
		position = "left",
		drawing = false,
		icon = {
			font = {
				family = settings.font.text,
				style = settings.font.style_map["Bold"],
				size = 14.0,
			},
			string = sid,
		},
		label = { drawing = false },
		click_script = "aerospace workspace " .. sid,
	})

	local apps = {}
	local member_names = { number.name }
	for i = 1, SLOTS_PER_WS do
		local app = sbar.add("item", "ws." .. sid .. ".app." .. i, {
			position = "left",
			drawing = false,
			icon = {
				font = { family = "sketchybar-app-font", style = "Regular", size = 16.0 },
			},
			label = { drawing = false },
		})
		apps[i] = app
		member_names[#member_names + 1] = app.name
	end

	local bracket = sbar.add("bracket", "ws." .. sid .. ".bracket", member_names, {
		background = {
			color = colors.bg2,
			corner_radius = settings.corner_radius,
			height = settings.item_height,
		},
		drawing = false,
	})

	local spacer = sbar.add("item", "ws." .. sid .. ".spacer", {
		position = "left",
		drawing = false,
		width = settings.pill_gap,
		icon = { drawing = false },
		label = { drawing = false },
		background = { drawing = false },
		padding_left = 0,
		padding_right = 0,
	})

	pills[sid] = { number = number, apps = apps, bracket = bracket, spacer = spacer }
end

local function render_pill(sid)
	local p = pills[sid]
	local wins = state.wins_by_sid[sid] or {}
	local active = (sid == state.focused_sid)
	local visible = active or #wins > 0

	local bg_color = active and colors.blue or colors.bg2
	if diff(p.bracket.name, "drawing", visible) then
		p.bracket:set({ drawing = visible })
	end
	if diff(p.bracket.name, "bg_color", bg_color) then
		p.bracket:set({ background = { color = bg_color } })
	end
	if diff(p.spacer.name, "drawing", visible) then
		p.spacer:set({ drawing = visible })
	end

	local num_color = active and colors.black or colors.grey
	if diff(p.number.name, "drawing", visible) then
		p.number:set({ drawing = visible })
	end
	if diff(p.number.name, "color", num_color) then
		p.number:set({ icon = { color = num_color } })
	end

	for i, item in ipairs(p.apps) do
		local w = wins[i]
		if w and visible then
			local glyph = glyph_for(w.name)
			local color
			if active and w.wid == state.focused_wid then
				color = colors.black
				-- elseif active then
				-- color = colors.bg1
			else
				color = colors.grey
			end
			if diff(item.name, "drawing", true) then
				item:set({ drawing = true })
			end
			if diff(item.name, "glyph", glyph) or diff(item.name, "color", color) then
				item:set({ icon = { string = glyph, color = color } })
			end
		else
			if diff(item.name, "drawing", false) then
				item:set({ drawing = false })
			end
		end
	end
end

local function render_all()
	for n = 1, NUM_WS do
		render_pill(tostring(n))
	end
end

local function refresh_windows(cb)
	sbar.exec("aerospace list-windows --all --format '%{workspace}|%{window-id}|%{app-name}'", function(out)
		local by_sid = {}
		for line in (out or ""):gmatch("[^\n]+") do
			local sid, wid, name = line:match("^(%S+)|(%S+)|(.+)$")
			if sid then
				local list = by_sid[sid]
				if not list then
					list = {}
					by_sid[sid] = list
				end
				list[#list + 1] = { wid = wid, name = name }
			end
		end
		state.wins_by_sid = by_sid
		if cb then
			cb()
		end
	end)
end

local function refresh_focused_window(cb)
	sbar.exec("aerospace list-windows --focused --format '%{window-id}'", function(out)
		state.focused_wid = (out or ""):match("(%S+)")
		if cb then
			cb()
		end
	end)
end

local function refresh_focused_workspace(cb)
	sbar.exec("aerospace list-workspaces --focused", function(out)
		state.focused_sid = (out or ""):match("(%S+)") or state.focused_sid
		if cb then
			cb()
		end
	end)
end

local hub = sbar.add("item", "ws.observer", {
	drawing = false,
	updates = "on",
})

hub:subscribe("aerospace_workspace_change", function(env)
	state.focused_sid = (env and env.FOCUSED_WORKSPACE) or state.focused_sid
	refresh_focused_window(render_all)
end)

hub:subscribe("aerospace_windows_change", function()
	refresh_focused_window(function()
		refresh_windows(render_all)
	end)
end)

refresh_focused_workspace(function()
	refresh_focused_window(function()
		refresh_windows(render_all)
	end)
end)
