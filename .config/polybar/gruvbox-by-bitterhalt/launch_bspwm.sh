#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
# polybar -c /home/eric/.config/polybar/gruvbox-by-bitterhalt/config.ini bspwm 2>&1 | tee -a /tmp/polybar.log & disown

if type "xrandr"; then                                       ─╯
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -c /home/eric/.config/polybar/gruvbox-by-bitterhalt/config.ini bspwm 2>&1 | tee -a /tmp/polybar.log & disown
  done
else
  polybar -c /home/eric/.config/polybar/gruvbox-by-bitterhalt/config.ini bspwm 2>&1 | tee -a /tmp/polybar.log & disown
fi

echo "Polybar launched..."
