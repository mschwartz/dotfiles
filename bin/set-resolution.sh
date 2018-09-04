#!/bin/bash

chosen=$(~/dotfiles/src/rez/rez | sort | rofi -dmenu)
set -- $(xrandr | head -2 | tail -1)
xrandr --output $1 --mode $chosen
