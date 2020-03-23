#!/bin/bash

read -r -d '' MENU <<-'EOF'
1) Rectangle
2) Active Window
3) Active Desktop
4) Screencast
5) Screencast w/Audio
6) Voice Memo
EOF

#chosen=`cat $menu | rofi -font "hack 20" -dmenu -p "Screenshot"`
chosen=`echo "$MENU" | rofi -font "hack 20" -dmenu -lines 5 -p "Screenshot"`
#chosen=`cat $menu` 
#echo $chosen
case $chosen in
  1*) 
    # Rectangle
    scrot -s $HOME/Downloads/`date +%Y-%m-%d_%H:%M:%S`.png
    ;;
  2*) 
    # Active Window
    scrot -d 2 -u $HOME/Downloads/`date +%Y-%m-%d_%H:%M:%S`.png
    ;;
  3*) 
    # Active Desktop
    scrot -d 2 $HOME/Downloads/`date +%Y-%m-%d_%H:%M:%S`.png
    ;;
  4*) 
    # Screencast
    ~/bin/videoshot.sh
    ;;
  5*) 
    # Screencast with audio
    ~/bin/videoshot.sh audio
    ;;
  6*) 
    # Voice memo
    ffmpeg -f alsa -i hw:0 $HOME/Downloads/memo-`date +%Y-%m-%d_%H:%M:%S`.wav
    ;;
esac
