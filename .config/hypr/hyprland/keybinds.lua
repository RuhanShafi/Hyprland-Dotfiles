-- Keybind Configuration
local programs = require("hyprland.programs")
local mainMod = "SUPER"

-- Application Launchers
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(programs.menu))

-- Window Management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("nwg-displays"))

-- Focus Movement
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Window Resizing (repeating binds)
hl.bind(mainMod .. " + SHIFT + RIGHT", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + LEFT", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + UP", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + DOWN", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { repeating = true })

-- Special Workspace (Scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media Controls
hl.bind(mainMod .. " + ALT + SPACE", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind(mainMod .. " + ALT + down", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind(mainMod .. " + ALT + left", hl.dsp.exec_cmd("playerctl position 5-"), { locked = true })
hl.bind(mainMod .. " + ALT + up", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind(mainMod .. " + ALT + right", hl.dsp.exec_cmd("playerctl position 5+"), { locked = true })

-- Media Keys
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("grim $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')"))
hl.bind(
	"CTRL + Print",
	hl.dsp.exec_cmd("grim -g \"$(slurp -o)\" $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')")
)
hl.bind(
	"CTRL + SHIFT + Print",
	hl.dsp.exec_cmd("grim -g \"$(slurp)\" $(xdg-user-dir PICTURES)/Screenshots/$(date +'%s_grim.png')")
)

-- Wallpaper Controls
hl.bind("CTRL + ALT + left", hl.dsp.exec_cmd("wpaperctl previous-wallpaper"))
hl.bind("CTRL + ALT + right", hl.dsp.exec_cmd("wpaperctl next-wallpaper"))

-- Waybar Toggle
hl.bind("CTRL + ALT + W", hl.dsp.exec_cmd("killall waybar && killall wpaperd || waybar && wpaperd"))

-- Logout Menu
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd("wlogout"))

-- Move window between monitors
hl.bind(mainMod .. " + X", hl.dsp.window.move({ monitor = "+1" }))

-- Load split-monitor workspace keybinds
-- Note: This is loaded inline below instead of as separate module
-- to avoid path issues

local mainMod = "SUPER"
local split = _G.SPLIT_WORKSPACES

if split then
	-- Bind keys 1-9,0 for workspaces on current monitor
	for i = 1, 10 do
		local key = i % 10 -- 10 becomes 0

		-- Switch to workspace i on current monitor
		hl.bind(mainMod .. " + " .. key, function()
			split.switch_to_workspace(i)
		end)

		-- Move window to workspace i on current monitor
		hl.bind(mainMod .. " + SHIFT + " .. key, function()
			split.move_window_to_workspace(i)
		end)
	end

	print("✓ Split-monitor workspace keybinds loaded")
else
	print("✗ Split-monitor workspaces not available - using default workspace keybinds")

	-- Fallback to normal workspace switching if split workspaces failed to load
	for i = 1, 10 do
		local key = i % 10
		hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
		hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	end
end
