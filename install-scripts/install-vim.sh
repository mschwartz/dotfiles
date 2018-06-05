#!/bin/sh

echo ">>> INSTALLING VIM"

mkdir -p ~/.vim/swapfiles

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

cd ~/dotfiles/vim
npm install -g jsctags eslint prettier eslint-plugin-prettier
git submodule update --init --recursive
cd bundle/tern_for_vim
npm install
#if [[ "$platform" == "macos" ]]; then
  cd ../YouCompleteMe
  if [ "$type" = "armv71" ]; then
    export YCM_CORES=1
    YCM_CORES=1 ./install.py --tern-completer --system-boost --clang-completer --system-libclang
  else
    YCM_CORES=8 ./install.py --tern-completer --clang-completer --system-libclang
  fi
#fi
