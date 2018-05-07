#!/bin/bash

INSTALL_PWD=`pwd`
########## Variables
. ./install-scripts/lib/platform.sh
source ./install-scripts/prerequisites.sh

##########

source ./install-scripts/install-dotfiles.sh

mkdir -p ~/.vim/swapfiles

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

source ./install-scripts/install-bin.sh

cd vim
npm install -g jsctags
git submodule update --init --recursive
cd bundle/tern_for_vim
npm install
#if [[ "$platform" == "macos" ]]; then
  cd ../YouCompleteMe
  if [ "$type" = "armv71" ]; then
    export YCM_CORES=1
    YCM_CORES=1 ./install.py --tern-completer --system-boost
  else
    ./install.py --tern-completer --system-boost
  fi
#fi

# oh my zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo cd $INSTALL_PWD
cd $INSTALL_PWD
source ./install-scripts/install-docker.sh

