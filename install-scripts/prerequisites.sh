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
    figlet \
    fzf \
    htop \
    gnupg \
    abook \
    cronie \
    fakeroot \
    hub \
    "

  sudo pacman --noconfirm -Syy figlet gnupg 

  if [[ "$platform_type" != "armv7l" ]]; then
    echo $platform_type
    echo "REFLECTOR"
    sudo pacman --noconfirm -Syy reflector
  fi
  figlet "Prerequisites for $platform"

  # uncomment this if keys are out of date - it is really slow
#  sudo pacman-key --refresh-keys
  gpgconf --kill all
  gpg --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E

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
  if [ "$platform_type" != "armv7l" ]]; then
    yay --noconfirm -Syy reflector-timer
    echo "enable/start reflector service"
    sudo systemctl enable reflector.service
    sudo systemctl start reflector.service
    echo "enable/start reflector timer"
    sudo systemctl enable reflector.timer
    sudo systemctl start reflector.timer
    yay -S --noconfirm checkupdates hwinfo mhwd 
  fi
  yay -S --noconfirm unzip unrar 
  tree fontconfig-infinality pacman-contrib geekbench find-the-command
  if [ "$platform_type" != "armv7l" ]]; then
    yay -S --noconfirm  dropbox dropbox-cli 
  fi
  yay -S --noconfirm  htop traceroute  rr-bin gometalinter python python2 python-pip kernel-modules-hook
  sudo systemctl daemon-reload
  sudo systemctl enable linux-modules-cleanup

  sudo pip3 install neovim

  rm -rf ~/.dropbox-dist
  install -dm0 ~/.dropbox-dist

  # enable services
  if [[ "$platform_type" != "armv7l" ]]; then
    yay -S --noconfirm thermald-git
    echo enable/start thermald
    sudo systemctl enable thermald.service
    sudo systemctl start thermald.service
    echo enable/start tlp
    sudo systemctl enable tlp.service
    sudo systemctl start tlp.service
  fi

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


