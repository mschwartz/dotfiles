#!/bin/bash

echo ">>> INSTALLING DOTFILES"

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

