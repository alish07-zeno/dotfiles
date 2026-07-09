#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5
## style-6     style-7     style-8     style-9     style-10

dir="$HOME/.config/rofi/type-4"
current=$(cat "$HOME/.config/hypr/themes/.current" 2>/dev/null || echo "catppuccin")

if [[ "$current" == "rectangular" || "$current" == *-rect ]]; then
    theme='style-rect'
else
    theme='style-5'
fi

pkill rofi || rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi