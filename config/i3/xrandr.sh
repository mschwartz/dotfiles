#!/bin/sh

/usr/bin/xrandr --newmode "5120x2880_60.00"  1276.50  5120 5560 6128 7136  2880 2883 2888 2982 -hsync +vsync
/usr/bin/xrandr --addmode Virtual1 5120x2880_60.00
/usr/bin/xrandr --output Virtual1 --mode 5120x2880_60.00

