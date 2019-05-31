#!/bin/bash

figlet "Install i3wm"
. ./install-scripts/lib/platform.sh

if [[ $platform == 'linux' ]]; then
  echo "installing prerequisites $platform"
  PACKAGES_TO_INSTALL="compton unclutter scrot conky i3blocks ssh i3lock ranger rxvt-unicode-256color w3m-img feh xclip dmenu qutebrowser kitty termite"
  echo $PACKAGES_TO_INSTALL
  sudo apt-get install -y $PACKAGES_TO_INSTALL
  sudo apt-get install -y  libpango1.0-dev libyajl-dev libstartup-notification0-dev libev-dev autoconf automake
fi

if [[ $platform == 'arch' ]]; then
  sudo pacman -S --noconfirm xorg xorg-server xorg-xrandr xterm xorg-xinit i3-gaps i3blocks i3status konsole compton \
    xscreensaver \
    dolphin \
    chromium \
    firefox \
    w3m \
    scrot ranger w3m feh xclip rofi qutebrowser sddm jsoncpp jsoncpp dunst libnotify i3lock
  sudo pacman -S --noconfirm ttf-font-awesome
  yay -Syy --noconfirm ttf-ms-fonts bumblebee-status google-chrome slack-desktop glxinfo wavebox-bin 
  yay -S --noconfirm fontconfig-infinality ttf-font-awesome ttf-yosemite-san-francicso-font-git siji-git material-icons.git ttf-material-icons ttf-ms-fonts
  yay -S --noconfirm rpm-org unclutter flameshot lxappearance wicd-patched redshift bluez blueman
  sudo systemctl enable sddm.service
fi

# i3 config files

if [[ $platform == 'linux' ]]; then
  mkdir -p ~/github/other
  # i3 gaps
  echo i3gaps
  if [[ ! -e ~/github/other/i3-gaps ]]; then
    cd ~/github/other
    git clone git@github.com:Airblader/i3 i3-gaps
  fi
  cd ~/github/other/i3-gaps
  autoreconf --force --install
  rm -rf build/
  mkdir -p build && cd build/
  ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
  make
  sudo make -j `nproc` install
  # polybar
  echo POLYBAR
  # dependencies per https://github.com/jaagr/polybar/wiki/Compiling
  sudo apt install -y xcb-proto cmake cmake-data pkg-config 
  sudo apt install -y libcairo2-dev 
  sudo apt install -y libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-util-cursor-dev
  sudo apt install -y python-xcbgen xcb-proto
  sudo apt install -y libxcb-image0-dev
  sudo apt install -y libxcb-ewmh-dev libxcb-icccm4-dev
  sudo apt install -y libjsoncpp-dev
  sudo apt install -y libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb-xrm0 libxcb-xrm-dev
  sudo apt install -y wireless-tools libiw-dev libcurlpp-dev
  if [[ ! -e ~/github/other/polybar ]]; then
    git clone --branch 3.2 --recursive git@github.com:jaagr/polybar
  fi
  cd ~/github/other
  mkdir polybar/build
  cd polybar/build
  cmake ..
  sudo make -j `nproc` install
fi

if [[ ! -e ~/github/other/wallpapers ]]; then
  mkdir -p ~/github/other
  cd ~/github/other
  git clone git@github.com:LukeSmithxyz/wallpapers
fi

cd ~/dotfiles/src/rez
make

echo "NERD FONTS"
if [[ ! -e ~/github/other/nerd-fonts ]]; then
  mkdir -p ~/github/other
  cd ~/github/other
  git clone --depth 1 git@github.com:ryanoasis/nerd-fonts
fi
cd ~/github/other/nerd-fonts
./install.sh
