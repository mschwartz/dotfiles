#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

echo ">>> INSTALLING PREREQUISITES FOR $platform"
if [[ $platform == 'linux' ]]; then
  PACKAGES_TO_INSTALL="\
    tmux \
    whois \
    git \
    mlocate \
    ranger \
    rsync \
    speedtest-cli \
    traceroute \
    source-highlight \
    curl \
    net-tools \
    neofetch \
    xscreensaver \
    imagemagick \
    scrot \
    urlview
  "

  sudo apt-get install figlet
  figlet "Prerequisites for $platform"

  sudo apt-get update
  sudo apt-get -y dist-upgrade
  sudo apt-get install -y $PACKAGES_TO_INSTALL

elif [[ $platform == 'arch' ]]; then
  PACKAGES_TO_INSTALL="\
    tmux \
    git \
    mlocate \
    ranger \
    rsync \
    man-pages \
    neofetch \
    speedtest-cli \
    source-highlight \
    whois \
    imagemagick \
    jq \
    scrot \
    traceroute \
    ntp \
    tlp \
    wget \
    pass \
    gnupg \
    abook \
    cronie \
    hub \
    "

  sudo pacman --noconfirm -Syy figlet gnupg reflector
  figlet "Prerequisites for $platform"

  # uncomment this if keys are out of date - it is really slow
#  sudo pacman-key --refresh-keys
  gpgconf --kill all
  gpg --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E

  yay --noconfirm -Syy reflector-timer

  sudo pacman -S --noconfirm $PACKAGES_TO_INSTALL
  echo "enable/start reflector service"
  sudo systemctl enable reflector.service
  sudo systemctl start reflector.service
  echo "enable/start reflector timer"
  sudo systemctl enable reflector.timer
  sudo systemctl start reflector.timer
  ln -sf /usr/bin/chromium /usr/local/bin/google-chrome
  if [[ ! -e ~/github/arch/yay ]]; then
    mkdir -p ~/github/arch
    cd ~/github/arch
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
  fi
  # install AUR packages
  yay -S --noconfirm unzip unrar hwinfo mhwd tree fontconfig-infinality checkupdates pacman-contrib geekbench command-not-found
  yay -S --noconfirm  htop dropbox dropbox-cli rr-bin kernel-modules-hook
  sudo systemctl daemon-reload
  sudo systemctl enable linux-modules-cleanup

  sudo pip3 install neovim

  rm -rf ~/.dropbox-dist
  install -dm0 ~/.dropbox-dist

  # enable services
  yay -S --noconfirm thermald-git
  echo enable/start thermald
  sudo systemctl enable thermald.service
  sudo systemctl start thermald.service
  echo enable/start tlp
  sudo systemctl enable tlp.service
  sudo systemctl start tlp.service

elif [[ $platform == 'macos' ]]; then
  install figlet
  figlet "Prerequisites for $platform"
  install neofetch 
  install ctags
  install boost 
  install boost-python 
  install boost-python3
fi

git config --global user.email "mykesx@gmail.com"
git config --global user.name "Michael Schwartz"


