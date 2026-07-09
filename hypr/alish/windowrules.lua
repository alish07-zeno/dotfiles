--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({
    -- Ignore maximize requests from all apps
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

hl.window_rule({
    -- Float common dialog and utility windows
    name  = "float-dialogs",
    match = { class = "^(file_progress|confirm|dialog|download|notification|error|splash|toolbar)$" },
    float = true,
})

hl.window_rule({
    -- Float file picker dialogs (gtk)
    name  = "float-file-pickers",
    match = { title = "^(Open File|Save File|Open Folder|Choose Files?).*$" },
    float = true,
})

hl.window_rule({
    -- Picture-in-picture always on top and floating
    name  = "pip-on-top",
    match = { title = "^(Picture.in.Picture)$" },
    float = true,
    pin   = true,
})
hl.layer_rule({
    -- stop the hyprpicker absurd animations
    name  = "no-anim-hyprpicker",
    match = { namespace = "^hyprpicker$" },
    no_anim = true,
})
-- Force Waypaper to float
hl.window_rule({
    match = { class = "waypaper" },
    float = true,
})   

-- for the volume button floating
hl.window_rule({
    match = { class = "org.pulseaudio.pavucontrol" },
    float = true,
    size = "850 550",
})   
hl.config({
    general = { ... },
    decoration = { ... },
    animations = { ... },
    
  misc = {
    animate_mouse_windowdragging = false,
    enable_swallow = false,
},
})