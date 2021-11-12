#!/bin/bash

figlet "Install vim"

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform == 'linux' ]]; then
  sudo apt-get install -y vim-nox ctags fonts-font-awesome neovim vim-youcompleteme
elif [[ $platform == 'arch' ]]; then
  sudo pacman -S --noconfirm vim ctags neovim
else
  brew install vim neovim
fi

echo ">>> INSTALLING VIM"

mkdir -p ~/.vim/swapfiles

#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PlugInstall +qall
nvim +PlugInstall +qall

cd ~/dotfiles/vim
npm install -g jsctags eslint prettier eslint-plugin-prettier
git submodule update --init --recursive
