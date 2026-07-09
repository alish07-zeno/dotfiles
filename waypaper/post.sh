#!/bin/bash
wall=$(grep '^wallpaper ' ~/.config/waypaper/config.ini | head -1 | cut -d'=' -f2- | sed "s/^ *//;s/^'//;s/'$//;s/^\"//" | sed 's/"$//')
wall="${wall/#\~/$HOME}"
ln -sfn "$wall" "$HOME/.config/hypr/themes/wallpapers/.current_image"