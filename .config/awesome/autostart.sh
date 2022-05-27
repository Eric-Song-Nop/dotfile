function run {
    if ! pgrep $1 > /dev/null ;
    then
        $@&
    fi
}
run xfce4-power-manager
run blueberry-tray
run volumeicon
run nm-applet
run nitrogen --restore
run cfw
run picom -b --config  $HOME/.config/awesome/picom.conf
run fcitx5
run systemctl --user start docker-desktop
