#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

figlet "Install Mutt"

if [[ $platform == 'arch' ]]; then
  sudo pacman --noconfirm -Syy neomutt notmuch 
elif [[ $platform_type == 'armv7l' ]]; then
  sudo apt install -y neomutt notmuch
elif [[ $platform == 'linux' ]]; then
  sudo apt install -y neomutt notmuch
fi
