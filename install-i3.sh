#!/bin/bash

. ./install-scripts/lib/platform.sh

if [[ $platform == 'linux' ]]; then
  echo "installing prerequisites $platform"
  PACKAGES_TO_INSTALL="compton unclutter scrot conky i3blocks ssh i3lock ranger rxvt-unicode-256color w3m-img feh xclip dmenu"
  echo $PACKAGES_TO_INSTALL
  sudo apt-get install -y $PACKAGES_TO_INSTALL
  sudo apt-get install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake
fi

if [[ $platform == 'arch' ]]; then
sudo pacman -S i3blocks i3status
fi

# i3 config files
mkdir -p ~/.config
mkdir -p ~/dotfiles_old/config
for file in ./config/*; do
  echo ln -sf ~/dotfiles/config/$(basename $file) ~/.config/$(basename $file)
  rm -rf ~/.config/$(basename $file)
  ln -sf ~/dotfiles/config/$(basename $file) ~/.config/$(basename $file)
done

if [[ $platform == 'linux' ]]; then
  if [[ ! -e ~/github/other/i3-gaps ]]; then
    mkdir -p ~/github/other
    cd ~/github/other
    git clone git@github.com:Airblader/i3 i3-gaps
  fi
  cd ~/github/other/i3-gaps
  autoreconf --force --install
  rm -rf build/
  mkdir -p build && cd build/
  ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
  make
  sudo make install
fi
