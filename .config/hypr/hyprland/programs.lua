-- Program Definitions
-- Store commonly used programs as global variables

-- Make these available globally
_G.PROGRAMS = {
	terminal = "kitty",
	fileManager = "dolphin",
	menu = "~/.config/rofi/scripts/rofi_launcher.sh",

	browser = "firefox",
	editor = "neovide",
}

-- Export for easy access
return _G.PROGRAMS
