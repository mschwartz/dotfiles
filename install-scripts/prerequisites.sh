#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

echo ">>> INSTALLING PREREQUISITES FOR $platform"
if [[ $platform == 'linux' ]]; then
  PACKAGES_TO_INSTALL="\
    git \
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
    git \
    neomutt \
    man-pages \
    xscreensaver \
    tmux \
    neofetch \
    speedtest-cli \
    source-highlight \
    imagemagick \
    dolphin \
    chromium \
    firefox \
    ranger \
    scrot \
    ntp \
    tlp \
    wget \
    pass \
    gnupg \
    w3m \
    notmuch \
    abook \
    cronie \
    hub \
    "

  sudo pacman -Syy
  sudo pacman-key --refresh-keys
  sudo pacman -S --noconfirm $PACKAGES_TO_INSTALL
  ln -sf /usr/bin/chromium /usr/local/bin/google-chrome
  if [[ ! -e ~/github/arch/yay ]]; then
    mkdir -p ~/github/arch
    cd ~/github/arch
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
  fi
  # install AUR packages
  yay -S --noconfirm unzip unrar hwinfo mhwd tree fontconfig-infinality checkupdates pacman-contrib thermald
  yay -S --noconfirm google-chrome slack-desktop htop dropbox glxinfo traceroute wavebox-bin rr-bin gometalinter python2 python-pip
  # enable services
  sudo systemctl enable thermald.service
  sudo systemctl enable tlp.service

elif [[ $platform == 'macos' ]]; then
  install neofetch 
  install ctags
  install boost 
  install boost-python 
  install boost-python3
fi

