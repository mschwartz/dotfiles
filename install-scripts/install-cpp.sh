#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

figlet "Install C++"

if [[ $platform == 'arch' ]]; then
  sudo pacman --no-confirm -Syy man-pages man-db cmake make clang lld lldb binutils libstdc++ libc++ gcc gdb boost libuv
  yay --no-confirm -Syy v8
  sudo systemctl enable man-db.service
  sudo systemctl start man-db.service
  sudo systemctl enable man-db.timer
  sudo systemctl start man-db.timer
elif [[ $platform_type == 'armv7l' ]]; then
  sudo apt update && sudo apt install -y man-db manpages cmake make build-essential libboost-all-dev 
elif [[ $platform == 'linux' ]]; then
  sudo apt update && sudo apt install -y man-db manpages cmake make build-essential libboost-all-dev 
fi
