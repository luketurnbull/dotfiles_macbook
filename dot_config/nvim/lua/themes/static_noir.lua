---@type Base46Table
local M = {}

M.base_30 = {
	white = "#ededed",
	black = "#0a0a0a",
	darker_black = "#050505",
	black2 = "#101010",
	one_bg = "#191919",
	one_bg2 = "#232323",
	one_bg3 = "#2d2d2d",
	grey = "#333333",
	grey_fg = "#666666",
	grey_fg2 = "#7d7d7d",
	light_grey = "#929292",
	red = "#ff4d42",
	baby_pink = "#ef6674",
	pink = "#ef6674",
	line = "#262626",
	green = "#9fd08a",
	vibrant_green = "#b7e2a3",
	nord_blue = "#7fb2e8",
	blue = "#7fb2e8",
	seablue = "#74cfd1",
	yellow = "#e6c15c",
	sun = "#f2d47c",
	purple = "#d093d0",
	dark_purple = "#9ba7e0",
	teal = "#74cfd1",
	orange = "#f3874f",
	cyan = "#74cfd1",
	statusline_bg = "#101010",
	lightbg = "#191919",
	pmenu_bg = "#101010",
	folder_bg = "#7fb2e8",
}

M.base_16 = {
	base00 = "#0a0a0a",
	base01 = "#101010",
	base02 = "#333333",
	base03 = "#7d7d7d",
	base04 = "#929292",
	base05 = "#ededed",
	base06 = "#f4f4f4",
	base07 = "#ffffff",
	base08 = "#ff4d42",
	base09 = "#f3874f",
	base0A = "#e6c15c",
	base0B = "#9fd08a",
	base0C = "#74cfd1",
	base0D = "#7fb2e8",
	base0E = "#d093d0",
	base0F = "#cc8b6a",
}

M.polish_hl = {
	defaults = {
		Comment = { italic = true },
	},
	treesitter = {
		["@comment"] = { italic = true },
	},
}

M.type = "dark"

return require("base46").override_theme(M, "static_noir")
