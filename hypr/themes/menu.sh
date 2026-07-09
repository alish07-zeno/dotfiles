#!/bin/bash
THEMES_DIR="$HOME/.config/hypr/themes"
CURRENT=$(cat "$THEMES_DIR/.current" 2>/dev/null || echo "catppuccin")
THEME_LIST=$(ls "$THEMES_DIR/palettes/" | sed 's/\.lua//' | while read t; do
  if [ "$t" = "$CURRENT" ]; then
    echo "  $t (active)"
  else
    echo "  $t"
  fi
done)
CHOICE=$(echo "$THEME_LIST" | rofi -dmenu -p "  Theme Switcher" -i -theme-str 'window {width: 400px;}' -theme-str 'listview {lines: 8;}')
[[ -z "$CHOICE" ]] && exit 0
THEME=$(echo "$CHOICE" | sed 's/^  //' | sed 's/ (active)//' | xargs)
# Inject theme colors into waybar
PALETTE=$(lua -e "
local p = dofile('$THEMES_DIR/palettes/$THEME.lua')
print('@define-color base #' .. p.base .. ';')
print('@define-color text #' .. p.text .. ';')
print('@define-color primary #' .. p.primary .. ';')
print('@define-color secondary #' .. p.secondary .. ';')
print('@define-color accent #' .. p.accent .. ';')
print('@define-color error #' .. p.error .. ';')
")

# Prepend variables to style.css
TMPFILE=$(mktemp)
echo "$PALETTE" > "$TMPFILE"
grep -v "^@define-color" ~/.config/waybar/style.css >> "$TMPFILE"
cp "$TMPFILE" ~/.config/waybar/style.css
rm "$TMPFILE"

pkill -SIGUSR2 waybar
lua "$THEMES_DIR/main.lua" "$THEME"
