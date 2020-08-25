#!/bin/bash

figlet "Install emacs"

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform == 'linux' ]]; then
  sudo apt-get install -y emacs26
elif [[ $platform == 'arch' ]]; then
    sudo pacman -S --noconfirm emacs
else # macos
    brew cask install emacs
fi

mkdir -p ~/github/other
#<<<<<<< HEAD
export OTHER="$HOME/github/other";
export ICONS_IN_TERMINAL="$OTHER/icons-in-terminal";

echo "  installing icons-in-terminal"
if [ ! -d $ICONS_IN_TEMRMINAL ]; then
  echo "$ICONS_IN_TEMRMINAL does not exist"
  cd $OTHER
  git clone git@:github.com/sebastiencs/icons-in-terminal.git
else
  echo "$ICONS_IN_TEMRMINAL exists"
fi
cd $HOME/github/other/icons-in-terminal
./install-autodetect.sh || ./install.sh
#=======
#pushd ~/github/other
git clone https://github.com/sebastiencs/icons-in-terminal.git

#git clone git@github.com:sebastiencs/icons-in-terminal.git
#cd icons-in-terminal
#./install-autodetect.sh
#>>>>>>> 6dfef233e8de0a2bad4665e2f0bedfe6cff523a5
