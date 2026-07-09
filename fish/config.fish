if status is-interactive
fastfetch
set -gx QT_QPA_PLATFORMTHEME qt6ct
# Commands to run in interactive sessions can go here
set fish_greeting
starship init fish | source
end
fish_add_path $HOME/.spicetify
