-- Native Split-Monitor Workspaces Implementation
-- Replicates split-monitor-workspaces plugin functionality in pure Lua
-- Each monitor gets its own set of 10 workspaces (1-10)

local WORKSPACES_PER_MONITOR = 10

-- Cache monitor indices
local monitor_indices = {}

-- Function to update monitor indices from hyprctl
local function update_monitor_indices()
    local handle = io.popen("hyprctl monitors -j")
    if not handle then return end
    
    local result = handle:read("*a")
    handle:close()
    
    -- Parse JSON to get monitor order
    local index = 0
    for monitor_block in result:gmatch('{[^}]*"name"%s*:%s*"([^"]+)"[^}]*}') do
        monitor_indices[monitor_block] = index
        index = index + 1
    end
    
    -- Simpler parsing - just count occurrences
    monitor_indices = {}
    index = 0
    for name in result:gmatch('"name"%s*:%s*"([^"]+)"') do
        if not monitor_indices[name] then
            monitor_indices[name] = index
            index = index + 1
        end
    end
end

-- Get monitor index
local function get_monitor_index(monitor_name)
    if not monitor_indices[monitor_name] then
        update_monitor_indices()
    end
    return monitor_indices[monitor_name] or 0
end

-- Get current monitor name
local function get_current_monitor()
    local handle = io.popen("hyprctl activeworkspace -j")
    if not handle then return nil end
    
    local result = handle:read("*a")
    handle:close()
    
    local monitor_name = result:match('"monitor"%s*:%s*"([^"]+)"')
    return monitor_name
end

-- Get absolute workspace ID from monitor name and relative ID (1-10)
local function get_workspace_for_monitor(monitor_name, relative_id)
    local monitor_index = get_monitor_index(monitor_name)
    return (monitor_index * WORKSPACES_PER_MONITOR) + relative_id
end

-- Switch to workspace on current monitor
local function switch_to_workspace(relative_id)
    local monitor_name = get_current_monitor()
    if not monitor_name then 
        print("Error: Could not get current monitor")
        return 
    end
    
    local workspace_id = get_workspace_for_monitor(monitor_name, relative_id)
    
    print(string.format("Switching to workspace %d (monitor: %s, relative: %d)", 
        workspace_id, monitor_name, relative_id))
    
    -- Use Lua dispatch instead of shell command
    hl.dispatch("workspace", tostring(workspace_id))
end

-- Move window to workspace on current monitor
local function move_window_to_workspace(relative_id)
    local monitor_name = get_current_monitor()
    if not monitor_name then 
        print("Error: Could not get current monitor")
        return 
    end
    
    local workspace_id = get_workspace_for_monitor(monitor_name, relative_id)
    
    print(string.format("Moving window to workspace %d (monitor: %s, relative: %d)", 
        workspace_id, monitor_name, relative_id))
    
    -- Use Lua dispatch
    hl.dispatch("movetoworkspace", tostring(workspace_id))
end

-- Initialize on startup
hl.on("hyprland.start", function()
    update_monitor_indices()
    print("✓ Split-monitor workspaces initialized")
    print("Monitor indices:", vim.inspect(monitor_indices))
end)

-- Update on monitor changes
hl.on("monitor.added", function()
    update_monitor_indices()
    print("Monitor added - indices updated:", vim.inspect(monitor_indices))
end)

hl.on("monitor.removed", function()
    update_monitor_indices()
    print("Monitor removed - indices updated:", vim.inspect(monitor_indices))
end)

-- Export functions globally
_G.SPLIT_WORKSPACES = {
    switch_to_workspace = switch_to_workspace,
    move_window_to_workspace = move_window_to_workspace,
    get_workspace_for_monitor = get_workspace_for_monitor,
    WORKSPACES_PER_MONITOR = WORKSPACES_PER_MONITOR,
}

print("✓ Split-monitor workspaces module loaded")

return _G.SPLIT_WORKSPACES
