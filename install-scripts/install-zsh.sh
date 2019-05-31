#!/bin/bash

figlet "Install zsh"

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform == 'linux' ]]; then
  sudo apt-get install -y zsh
elif [[ $platform == 'arch' ]]; then
  sudo pacman --noconfirm -S zsh
elif [[ $platform == 'macos' ]]; then
  install "zsh"
fi
sudo chown -R $(whoami) /usr/local/share/zsh/site-functions
chsh -s $(which zsh)
# oh my zsh
cd ~
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

