#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

figlet "Install Go"

if [[ $platform == 'arch' ]]; then
  yay --noconfirm -Syy go go-tools gometalinter-git
elif [[ $platform_type == 'armv7l' ]]; then
  sudo add-apt-repository ppa:longsleep/golang-backports
  sudo apt-get update
  sudo apt-get install golang-go golang-go.tools
elif [[ $platform == 'linux' ]]; then
  sudo add-apt-repository ppa:longsleep/golang-backports
  sudo apt-get update
  sudo apt-get install golang-go golang-go.tools
fi
