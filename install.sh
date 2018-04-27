#!/bin/bash

########## Variables
. ./install-scripts/lib/platform.sh
source ./install-scripts/prerequisites.sh

##########

# create dotfiles_old in homedir
dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="inputrc profile bash_profile bashrc bash_aliases vimrc vim zlogin zshrc zprofile zshenv Xresources ctags tmux tmux.conf ackrc ideavimrc agignore eslintrc.js clang-format"    # list of files/folders to symlink in homedir

#echo "Creating $olddir for backup of any existing dotfiles in ~"
#mkdir -p $olddir
#rm -rf $olddir/*
#echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
  #echo "Moving any existing dotfiles from ~ to $olddir"
  #echo mv ~/.$file $olddir/.$file
  #mv ~/.$file $olddir/.$file
  echo "Creating symlink to $file in home directory."
  echo rm -f ~/.$file
  rm -f ~/.$file
  ls -ldg ~/.$file
  echo ln -sf $dir/$file ~/.$file
  ln -sf $dir/$file ~/.$file
done

mkdir -p ~/.vim/swapfiles

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

rm -rf $HOME/dotfiles/bin/node_modules
mkdir -p $HOME/bin
for bin in `ls $HOME/dotfiles/bin`; do
    ln -sf $HOME/dotfiles/bin/$bin $HOME/bin/$bin
done
pushd $HOME/bin
rm -rf ./node_modules
npm install
popd

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

source ./install-scripts/install-docker.sh

