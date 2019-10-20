#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

figlet "Install Java"

if [[ $platform == 'arch' ]]; then
  # probably a few more Java related packages might be good to install here (jdbc, etc.)
  sudo pacman -Syy jdk11-openjdk
  yay -Syy intellij-idea-community-edition
elif [[ $platform_type == 'armv7l' ]]; then
  sudo apt update && sudo apt upgrade && sudo apt install openjdk-11-jdk
elif [[ $platform == 'linux' ]]; then
  sudo apt update && sudo apt upgrade && sudo apt install openjdk-11-jdk
fi
