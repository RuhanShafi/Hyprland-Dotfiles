-- split_workspaces.lua
hl.config({
	plugin = {
		split_monitor_workspaces = {
			count = 10,
			keep_focused = 0,
			enable_notifications = 0,
			enable_persistent_workspaces = 1, -- needed so waybar sees workspaces on boot
			enable_wrapping = 1,
			link_monitors = 0,
		},
	},
})

local smw = hl.plugin.split_monitor_workspaces

for i = 1, 10 do
	local key = tostring(i % 10) -- 10 → "0"
	hl.bind("SUPER + " .. key, function()
		return smw.workspace(i)
	end)
	hl.bind("SUPER + SHIFT + " .. key, function()
		return smw.move_to_workspace_silent(i)
	end)
end
