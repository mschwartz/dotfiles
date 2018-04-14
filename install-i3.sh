#!/bin/bash

type=`uname -m`
unamestr=`uname`
platform='unknown'
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'armv7' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='macos'
fi

if [[ $platform == 'linux' ]]; then
  echo "installing prerequisites $platform"
  PACKAGES_TO_INSTALL="conky i3blocks ssh i3lock ranger rxvt-unicode-256color w3m-img feh xclip"
  echo $PACKAGES_TO_INSTALL
  sudo apt-get install -y $PACKAGES_TO_INSTALL
fi

# i3 config files
mkdir -p ~/.config
mkdir -p ~/dotfiles_old/config
for file in ./config/*; do
  echo ln -sf ~/dotfiles/config/$(basename $file) ~/.config/$(basename $file)
  unlink ~/.config/$(basename $file)
  ln -sf ~/dotfiles/config/$(basename $file) ~/.config/$(basename $file)
done

