#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

figlet "Install Rust"

if [[ $platform == 'arch' ]]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
#  sudo pacman --noconfirm -Syy rust rustup
elif [[ $platform_type == 'armv7l' ]]; then
  curl https://sh.rustup.rs -sSf | sh
elif [[ $platform == 'linux' ]]; then
  curl https://sh.rustup.rs -sSf | sh
elif [[ $platform == 'macos' ]]; then
  brew install rustup
  rustup-init
fi
