#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform == 'arch' ]]; then
  sudo pacman --noconfirm -S intel-ucode
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  yay --noconfirm -Syy git-secrets
elif [[ $platform == 'macos' ]]; then
  brew install git-secrets
fi

