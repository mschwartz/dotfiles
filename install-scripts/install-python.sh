#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

figlet "Install Python"

if [[ $platform == 'arch' ]]; then
  sudo pacman --noconfirm -Syy python python2 python-pip 
  sudo pip3 install neovim
elif [[ $platform_type == 'armv7l' ]]; then
  sudo apt update
  sudo apt install -y python-dev
elif [[ $platform == 'linux' ]]; then
  sudo apt update
  sudo apt install -y python-dev
elif [[ $platform == 'macos' ]]; then
  brew install python3
fi
