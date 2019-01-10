#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform == 'linux' ]]; then
  sudo apt-get install -y vim-nox ctags fonts-font-awesome neovim
elif [[ $platform == 'arch' ]]; then
  sudo pacman -S --noconfirm vim ttf-font-awesome ctags neovim

fi
echo "NERD FONTS"
if [[ ! -e ~/github/other/nerd-fonts ]]; then
  mkdir -p ~/github/other
  cd ~/github/other
  git clone --depth 1 git@github.com:ryanoasis/nerd-fonts
fi
cd ~/github/other/nerd-fonts
./install.sh

echo ">>> INSTALLING VIM"

mkdir -p ~/.vim/swapfiles

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

cd ~/dotfiles/vim
npm install -g jsctags eslint prettier eslint-plugin-prettier
git submodule update --init --recursive
cd bundle/tern_for_vim
npm install
if [[ "$platform" == "macos" ]]; then
  cd ../YouCompleteMe
  if [ "$type" = "armv71" ]; then
    export YCM_CORES=1
    YCM_CORES=1 ./install.py --tern-completer --system-boost --clang-completer --system-libclang
  else
    YCM_CORES=8 ./install.py --tern-completer --clang-completer --system-libclang
  fi
fi
