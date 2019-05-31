#!/bin/bash

figlet "Install security"

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform == 'arch' ]]; then
  sudo pacman --noconfirm -S intel-ucode
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  yay --noconfirm -Syy git-secrets
elif [[ $platform == 'macos' ]]; then
  brew install git-secrets
fi
git secrets --register-aws --global
git secrets --install -f ~/.git-templates/git-secrets
git config --global  init.templateDir ~/.git-templates/git-secrets

