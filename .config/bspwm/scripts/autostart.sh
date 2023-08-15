#!/usr/bin/bash

# Polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# Set display from arandr saved script
sh ~/.screenlayout/monitor.sh &
# Notifications
# /usr/bin/dunst &

# Wallpaper
feh --bg-fill /home/eric/Pictures/gruvbox-dark-rainbow.png &
# nitrogen --restore &
# Dex
# dex -a -s /etc/xdg/autostart/:~/.config/autostart/  &
dex --autostart --environment bspwm &
# Picom
picom -b &
# Network Applet
nm-applet --indicator &

# Cursor
xsetroot -cursor_name left_ptr &

# Low battery notifier
sh ~/.config/bspwm/scripts/low_bat_notifier.sh &

fcitx5 &

xfce4-clipman &

jetbrains-toolbox &

gnome-keyring-daemon -s --components=pkcs11,secrets,ssh &
# Bar
sh /home/eric/.config/polybar/gruvbox-by-bitterhalt/launch_bspwm.sh &
