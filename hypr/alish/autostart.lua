-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
-- hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE XDG_SESSION_TYPE XDG_SESSION_DESKTOP && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP HYPRLAND_INSTANCE_SIGNATURE XDG_SESSION_TYPE XDG_SESSION_DESKTOP && systemctl --user start --wait hyprland-session.target ; systemctl --user reset-failed xdg-desktop-portal.service xdg-desktop-portal-hyprland.service ; systemctl --user restart xdg-desktop-portal.service xdg-desktop-portal-hyprland.service")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland") 
    hl.exec_cmd("systemctl --user start hyprland-session.target")
    hl.exec_cmd("waybar")   
    hl.exec_cmd("swaync-ca")          
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("cava")         
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic")
    hl.exec_cmd("hyprctl setcursor 19") 
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
end)