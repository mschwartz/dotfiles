#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

echo ">>> INSTALLING PREREQUISITES FOR $platform"
if [[ $platform == 'linux' ]]; then
  PACKAGES_TO_INSTALL="\
    build-essential \
    speedtest-cli \
    source-highlight \
    zsh \
    cmake \
    vim-youcompleteme \
    python-dev \
    libboost-all-dev \
    tmux \
    curl \
    ruby-dev \
    net-tools \
    neofetch \
    xscreensaver \
    imagemagick \
    scrot \
    urlview
  "

  sudo apt-get update
  sudo apt-get -y dist-upgrade
  sudo apt-get install -y $PACKAGES_TO_INSTALL

elif [[ $platform == 'arch' ]]; then
  PACKAGES_TO_INSTALL="\
    xscreensaver \
    speedtest-cli \
    source-highlight \
    imagemagick \
    dolphin \
    chromium \
    firefox \
    ranger \
    scrot \
    wget \
    "
  sudo pacman -S --noconfirm $PACKAGES_TO_INSTALL
  ln -sf /usr/bin/chromium /usr/local/bin/google-chrome

elif [[ $platform == 'macos' ]]; then
  install neofetch 
  install ctags
  install boost 
  install boost-python 
  install boost-python3
fi

