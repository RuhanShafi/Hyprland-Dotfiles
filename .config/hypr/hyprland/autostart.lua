-- Autostart Configuration
-- Programs to launch on Hyprland start

hl.on("hyprland.start", function()
	-- Load plugins
	hl.exec_cmd("hyprpm reload -n")

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

	-- Hyprlock slideshow
	hl.exec_cmd("~/dotfiles/.config/hypr/hyprlock/slideshow.sh &")

	-- KDE integrations
	hl.exec_cmd("/usr/lib/pam_kwallet_init")
	hl.exec_cmd("kwalletd6")
	hl.exec_cmd("/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg")

	-- Blue light filter
	hl.exec_cmd("hyprsunset")

	hl.exec_cmd("firefox", { workspace = "1" })
	hl.exec_cmd("spotify-launcher ", { workspace = "10" })
end)
