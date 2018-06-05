#!/bin/sh

echo ">>> INSTALLING ZSH"

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform == 'linux' ]]; then
  sudp apt-get install -y zsh
  sudo chown -R $(whoami) /usr/local/share/zsh/site-functions
elif [[ $platform == 'macos' ]]; then
  install "zsh"
fi
chsh -s $(which zsh)
# oh my zsh
cd ~
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

