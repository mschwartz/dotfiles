#!/bin/bash

read -r -d '' MENU <<-'EOF'
1) Active Window
2) Active Desktop
3) Rectangle
4) Screencast
5) Voice Memo
EOF

#chosen=`cat $menu | rofi -font "hack 20" -dmenu -p "Screenshot"`
chosen=`echo "$MENU" | rofi -font "hack 20" -dmenu -lines 5 -p "Screenshot"`
#chosen=`cat $menu` 
#echo $chosen
case $chosen in
  1*) 
    # Active Window
    scrot -u $HOME/Downloads/`date +%Y-%m-%d_%H:%M:%S`.png
    ;;
  2*) 
    # Active Desktop
    scrot $HOME/Downloads/`date +%Y-%m-%d_%H:%M:%S`.png
    ;;
  3*) 
    # Rectangle
    scrot -s $HOME/Downloads/`date +%Y-%m-%d_%H:%M:%S`.png
    ;;
  4*) 
    # Screencast
    echo ffmpeg
    ;;
  5*) 
    # Voice memo
    echo Voice
    ;;
esac
