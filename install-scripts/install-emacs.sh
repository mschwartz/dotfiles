#!/bin/bash

figlet "Install emacs"

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform == 'linux' ]]; then
  sudo apt-get install -y emacs26
elif [[ $platform == 'arch' ]]; then
    sudo pacman -S --noconfirm emacs
else # macos
    brew cask install emacs
fi

mkdir -p ~/github/other
pushd ~/github/other
#git clone https://github.com/sebastiencs/icons-in-terminal.git

git clone git@github.com:sebastiencs/icons-in-terminal.git
cd icons-in-terminal
./install-autodetect.sh
