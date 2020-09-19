#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

figlet "Install Rust"

if [[ $platform == 'arch' ]]; then
  sudo pacman --noconfirm -Syy rust
elif [[ $platform_type == 'armv7l' ]]; then
  curl https://sh.rustup.rs -sSf | sh
elif [[ $platform == 'linux' ]]; then
  curl https://sh.rustup.rs -sSf | sh
elif [[ $platform == 'macos' ]]; then
  brew install rustup
  rustup-init
fi
