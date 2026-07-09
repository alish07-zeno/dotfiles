#!/bin/bash
LOCK=/tmp/waybar-ws-scroll.lock
[ -f "$LOCK" ] && exit 0
touch "$LOCK"

if [ "$1" = "up" ]; then
  hyprctl dispatch 'hl.dsp.focus({ workspace = "+1" })'
else
  hyprctl dispatch 'hl.dsp.focus({ workspace = "-1" })'
fi

sleep 0.2
rm -f "$LOCK"
