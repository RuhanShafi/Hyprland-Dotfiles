-- Window Rules Configuration

-- Suppress maximize events for all windows
hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Float Dolphin windows
hl.window_rule({
    name = "dolphin-float",
    match = { 
        class = "^org%.kde%.dolphin$",
    },
    float = true,
})

-- Fix XWayland drag issues
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

-- Picture-in-Picture windows
hl.window_rule({
    name = "pip-float",
    match = { title = "Picture-in-Picture" },
    float = true,
    pin = true,
    size = { 640, 360 },
})

-- XWayland video bridge
hl.window_rule({
    name = "xwaylandvideobridge",
    match = { class = "^(xwaylandvideobridge)$" },
    opacity = 0.0,
    no_focus = true,
    no_anim = true,
    no_shadow = true,
    border_size = 0,  -- Use border_size instead of no_border
})

-- Steam windows
hl.window_rule({
    name = "steam-float",
    match = { 
        class = "^(steam)$",
        title = "^(Friends List|Steam Settings)$"
    },
    float = true,
})

-- Example: Make specific windows immediate (no wait for frame)
-- Useful for gaming
-- hl.window_rule({
--     name = "gaming-immediate",
--     match = { class = "^(steam_app_).*" },
--     immediate = true,
-- })
