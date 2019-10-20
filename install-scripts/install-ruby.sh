#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

figlet "Install Rust"

if [[ $platform == 'arch' ]]; then
  sudo pacman --noconfirm -Syy ruby
elif [[ $platform_type == 'armv7l' ]]; then
  sudo apt update && sudo apt install -y ruby-dev
elif [[ $platform == 'linux' ]]; then
  sudo apt update && sudo apt install -y ruby-dev
fi
