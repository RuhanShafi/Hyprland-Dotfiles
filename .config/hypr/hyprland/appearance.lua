-- Appearance Configuration
-- Colors are from Catppuccin Mocha theme

-- Load colors module
local colors = require("hyprland.colors")

hl.config({
	general = {
		gaps_in = 2.5,
		gaps_out = 7.5,
		border_size = 2,

		col = {
			active_border = colors.lavender,
			inactive_border = colors.surface0,
		},

		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 10,

		active_opacity = 0.9,
		inactive_opacity = 0.8,

		shadow = {
			enabled = false,
		},

		blur = {
			enabled = true,
			size = 5,
			passes = 1,
			vibrancy = 0.5,
		},
	},

	misc = {
		force_default_wallpaper = 1,
		disable_hyprland_logo = true,
		-- vfr = true, -- Variable frame rate for battery saving
	},
})

-- Dwindle Layout Settings
hl.config({
	dwindle = {
		-- pseudotile = true,
		preserve_split = true,
	},
})

-- Master Layout Settings
hl.config({
	master = {
		new_status = "master",
	},
})

-- Load custom animations
require("hyprland.animations")
