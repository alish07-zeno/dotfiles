#!/usr/bin/env bash

TMPFILE=/tmp/cava-waybar-out
bars=(" " "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█")

if ! pgrep -f "cava -p $HOME/.config/cava/waybar" > /dev/null; then
    killall cava 2>/dev/null
    rm -f "$TMPFILE"
    cava -p $HOME/.config/cava/waybar 2>/dev/null | while IFS=';' read -ra values; do
        out=""
        for v in "${values[@]}"; do
            v="${v//[^0-9]/}"
            [[ -z "$v" ]] && v=0
            (( v > 8 )) && v=8
            out+="${bars[$v]}"
        done
        echo "$out" > "$TMPFILE"
    done &
fi

if [[ -f "$TMPFILE" ]]; then
    cat "$TMPFILE"
else
    echo "▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁"
fi   