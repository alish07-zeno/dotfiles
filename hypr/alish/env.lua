-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- nvidia specific
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- cursor
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- toolkit backend
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland,x11")
hl.env("CLUTTER_BACKEND", "wayland")

-- XDG
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- QT
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1.25")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- electron
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")