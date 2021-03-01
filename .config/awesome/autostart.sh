#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
#run dex $HOME/.config/autostart/arcolinux-welcome-app.desktop
#run xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
run xrandr --output HDMI-1 --mode 1920x1080 --pos 2736x0 --rotate normal --output eDP-1 --primary --mode 2736x1824 --pos 0x0 --rotate normal
run nm-applet
#run caffeine
run pamac-tray
#run variety
run xfce4-power-manager
run xfsettingsd
run blueberry-tray
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run numlockx on
run volumeicon

run conky -c $HOME/.config/awesome/qlocktwo -d -q
#run conky -c $HOME/.config/awesome/system-overview -d -q
#you can set wallpapers in themes as well
# feh --bg-fill /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg &
#run applications from startup
#run firefox
#run atom
#run dropbox
#run insync start
#run spotify
#run ckb-next -b
#run discord
#run telegram-desktop
