#!/usr/bin/env bash
set -e

# ---- My Hyprland Dotfiles Installer ----
# This script symlinks every config folder in this repo into ~/.config
# Symlinks (not copies) mean future `git pull` updates apply instantly.

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

FOLDERS=(hypr waybar rofi kitty fish swaync wlogout waypaper nvim fastfetch cava)

echo "==> Dotfiles source: $DOTFILES_DIR"
echo "==> Target: $CONFIG_DIR"
echo "==> Backups (if needed) go to: $BACKUP_DIR"
echo ""

mkdir -p "$CONFIG_DIR"

for folder in "${FOLDERS[@]}"; do
    src="$DOTFILES_DIR/$folder"
    dest="$CONFIG_DIR/$folder"

    if [ ! -d "$src" ]; then
        echo "!! Skipping $folder (not found in repo)"
        continue
    fi

    # If something already exists at the destination and it's not already
    # our symlink, back it up before overwriting.
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        if [ "$(readlink -f "$dest")" = "$(readlink -f "$src")" ]; then
            echo "== $folder already linked, skipping"
            continue
        fi
        mkdir -p "$BACKUP_DIR"
        echo "-- Backing up existing $folder to $BACKUP_DIR/"
        mv "$dest" "$BACKUP_DIR/"
    fi

    ln -s "$src" "$dest"
    echo "++ Linked $folder"
done

# starship.toml is a single file, not a folder
if [ -f "$DOTFILES_DIR/starship.toml" ]; then
    dest="$CONFIG_DIR/starship.toml"
    if [ -e "$dest" ] && [ "$(readlink -f "$dest")" != "$(readlink -f "$DOTFILES_DIR/starship.toml")" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
    fi
    ln -sf "$DOTFILES_DIR/starship.toml" "$dest"
    echo "++ Linked starship.toml"
fi

echo ""
echo "Done! Restart Hyprland or your session for everything to take effect."
echo ""
echo "Don't forget to edit these for your own machine:"
echo "  - hypr/alish/monitors.lua  (your monitor names/resolution)"
echo "  - hypr/hyprlock.conf       (your own lockscreen image path)"
