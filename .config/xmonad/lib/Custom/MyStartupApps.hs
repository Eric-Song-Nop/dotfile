module Custom.MyStartupApps where

import XMonad
import XMonad.Util.SpawnOnce

myWallpaperPath :: String
myWallpaperPath = "~/wallpapers/out_the_window_darker.png"

myStartupHook :: X ()
myStartupHook = do
    let wallpaperCmd = "feh --bg-scale " ++ myWallpaperPath
        autolockCmd = "xautolock -time 5 -locker \"i3lock -i ~/wallpapers/out_the_window_darker_1440.png\" -detectsleep &"
        blurCmd = "~/scripts/feh-blur.sh -s; ~/scripts/feh-blur.sh -d"
        picomCmd = "killall -9 picom; sleep 2 && picom -b &"
        easyeffectsCmd = "easyeffects --gapplication-service &"
        ewwCmd = "~/.config/eww/scripts/startup.sh"
        nmapplet = "nm-applet &"
        cfw = "~/Downloads/cfw/cfw"
    sequence_ [spawn wallpaperCmd, spawn autolockCmd, spawn blurCmd, spawn picomCmd, spawnOnce easyeffectsCmd, spawn ewwCmd, spawn nmapplet, spawn cfw]
