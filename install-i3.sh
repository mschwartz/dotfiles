#!/bin/bash

PACKAGES_TO_INSTALL= \
  conky \
  i3blocks \
  ssh \
  i3exit \
  i3lock \
  ranger \
  rxvt-unicode-256color \
  w3m-img \
  feh \
  xclip

sudo apt-get install -y $PACKAGES_TO_INSTALL

# i3 config files
mkdir -p ~/.config
mkdir -p ~/dotfiles_old/config
for file in ./config/*; do
  echo ln -sf ~/dotfiles/config/$(basename $file) ~/.config/$(basename $file)
  ln -sf ~/dotfiles/config/$(basename $file) ~/.config/$(basename $file)
done

