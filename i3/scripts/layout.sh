#!/bin/sh

if [ $USER != "toni" ]; then
xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --pos 7040x0 --rotate left --output DP-0 --mode 2560x1440 --pos 4480x0 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --mode 1920x1080 --pos 0x360 --rotate normal --output DP-4 --primary --mode 2560x1440 --pos 1920x0 --rotate normal --output DP-5 --off

fi
