#!/bin/bash

echo ">>> INSTALLING NODEJS"

. ~/dotfiles/install-scripts/lib/platform.sh

echo $platform
if [[ $platform == 'linux' ]]; then
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
  sudo apt-get update
  sudo apt-get install -y nodejs
  npm config set prefix '/usr/local'
  sudo mkdir -p $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
  sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
  chsh -s $(which zsh)
elif [[ $platform == 'macos' ]]; then
  install node
fi

npm config set prefix '/usr/local'
sudo mkdir -p $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
