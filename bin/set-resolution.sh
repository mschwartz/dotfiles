#!/bin/bash

current=$(xdpyinfo | awk '/dimensions/{print $2}')
chosen=$(~/dotfiles/src/rez/rez | sort -r | rofi -font "hack 20" -lines 10 -dmenu -p "Choose a resolution ($current)")
set -- $(xrandr | head -2 | tail -1)
xrandr --output $1 --mode $chosen
