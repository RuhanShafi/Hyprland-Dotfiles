-- Custom Animation Behaviors
-- Advanced Lua scripting for dynamic animations

-- Example: Notification on window focus
-- Uncomment to enable
--[[
hl.on("window.active", function(window)
    if window then
        hl.notification.create({
            text = "Focused: " .. (window.title or "Unknown"),
            timeout = 2000,
            icon = "ok",
        })
    end
end)
]]

-- Example: Auto-tile windows based on workspace
--[[
hl.on("window.open", function(window)
    local workspace = hl.workspace.active()
    if workspace and workspace.id == 2 then
        -- Automatically tile all windows on workspace 2
        hl.dsp.window.float({ action = "disable", window = window })
    end
end)
]]

-- Example: Dynamic workspace animations based on direction
--[[
local last_workspace = 1

hl.on("workspace.active", function(workspace)
    if not workspace then return end
    
    local direction = workspace.id > last_workspace and "right" or "left"
    last_workspace = workspace.id
    
    -- You could dynamically change animation style here
    print(string.format("Workspace %d (moved %s)", workspace.id, direction))
end)
]]

-- Example: Auto-group windows by class
--[[
local window_groups = {}

hl.on("window.open", function(window)
    if not window or not window.class then return end
    
    local class = window.class
    
    if not window_groups[class] then
        window_groups[class] = {}
    end
    
    table.insert(window_groups[class], window)
    
    -- If more than 2 windows of same class, group them
    if #window_groups[class] > 2 then
        print(string.format("Grouping %d windows of class: %s", #window_groups[class], class))
        -- hl.dsp.window.group_toggle()
    end
end)
]]

print("✓ Custom animation behaviors loaded")
