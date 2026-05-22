-- Autostart Configuration
-- Programs to launch on Hyprland start

hl.on("hyprland.start", function()
	-- Status bar
	hl.exec_cmd("waybar")

	-- Network manager applet
	hl.exec_cmd("nm-applet --indicator")

	-- Bluetooth applet
	hl.exec_cmd("blueman-applet")

	-- Wallpaper daemon
	hl.exec_cmd("wpaperd -d")

	-- Idle daemon
	hl.exec_cmd("hypridle")

	-- KDE integrations
	hl.exec_cmd("/usr/lib/pam_kwallet_init")
	hl.exec_cmd("kwalletd6")
	hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg")

	-- Blue light filter
	hl.exec_cmd("hyprsunset")

	-- Notification daemon
	-- hl.exec_cmd("swaync")

	-- Launch apps on specific workspaces
	hl.dsp.exec_cmd({
		command = "firefox",
		rules = { workspace = 1, silent = true },
	})

	hl.dsp.exec_cmd({
		command = "spotify-launcher",
		rules = { workspace = 10, silent = true },
	})
end)
