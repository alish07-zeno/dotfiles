---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity  = 0,    -- -1.0 - 1.0, 0 means no modification
        repeat_rate  = 35,   -- key repeat speed once held (default 25 feels sluggish)
        repeat_delay = 250,  -- ms before repeat kicks in

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace"
})

-- Per-device config — update "epic-mouse-v1" to your actual device name
-- Run `hyprctl devices` to find it
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})