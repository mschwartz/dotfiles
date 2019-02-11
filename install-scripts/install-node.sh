#!/bin/bash

echo ">>> INSTALLING NODEJS"

. ~/dotfiles/install-scripts/lib/platform.sh

echo $platform
if [[ $platform == 'linux' ]]; then
  curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
  sudo apt-get update
  sudo apt-get install -y nodejs
elif [[ $platform == 'arch' ]]; then
  sudo pacman -S --noconfirm nodejs npm
elif [[ $platform == 'macos' ]]; then
  install node
fi

npm config set prefix '/usr/local'
sudo mkdir -p $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}

echo "1"
npm install -g eslint eslint-plugin-class-property eslint-plugin-jest eslint-plugin-react jsctags react-native-cli prettier webpack babel-cli babel-eslint babel-plugin-transform-es2015-modules-commonjs babel-preset-stage-0 babel-preset-stage-2 create-react-app
echo "2"
npm install -g eslint@4.6.0 
echo "3"
npm install -g typescript-eslint-parser
echo "4"
npm install -g eslint-plugin-prettier
