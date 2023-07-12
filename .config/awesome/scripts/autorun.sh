#!/usr/bin/bash

run() {
    echo $1
    if ! pgrep -f "$1"; then
        "$@" &
    fi
}

run "nvidia-settings" -a CurrentMetaMode='DPY-3: nvidia-auto-select @1920x1080 +0+0 {ViewPortIn=1920x1080,ViewPortOut=2560x1440+0+0}'
# run "feh" --bg-scale ~/wallpapers/out_the_window_darker.png
run "xautolock" -time 5 -locker 'i3lock -i ~/wallpapers/out_the_window_darker_1440.png' -detectsleep
run "picom" -b
run "nm-applet"
run "fcitx5"
# run "gnome-keyring-daemon" --start --components=pkcs11,secrets,ssh

