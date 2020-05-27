#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

figlet "Install C++"

if [[ $platform == 'arch' ]]; then
  sudo pacman --noconfirm -Syy man-pages man-db cmake make clang lld lldb binutils gcc gdb boost libuv cgdb ncurses
  yay --noconfirm -Syy ccls-git
  yay --noconfirm -S libstdc++5
#  yay --noconfirm -S libc++
#  echo "enable man-db.service"
#  sudo systemctl enable man-db.service
  echo "start man-db.service"
  sudo systemctl start man-db.service
  echo "enable man-db.timer"
  sudo systemctl enable man-db.timer
  echo "start man-db.timer"
  sudo systemctl start man-db.timer
elif [[ $platform_type == 'armv7l' ]]; then
  sudo apt update && sudo apt install -y man-db manpages cmake make build-essential libboost-all-dev 
elif [[ $platform == 'linux' ]]; then
    sudo apt update && sudo apt install -y man-db manpages cmake make build-essential libboost-all-dev
else # macos
    brew install gcc gdb
fi
