#!/bin/bash

figlet "Installing dotfiles"

# create dotfiles_old in homedir
dir=~/dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files="XResources inputrc profile bash_profile bashrc bash_aliases vimrc vim zlogin zshrc zprofile zshenv Xresources ctags tmux tmux.conf ackrc ideavimrc agignore eslintrc.js clang-format"    # list of files/folders to symlink in homedir

echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
rm -rf $olddir/*
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
echo "Moving any existing dotfiles from ~ to $olddir"
for file in $files; do
  echo mv ~/.$file $olddir/.$file
  rm -f $olddir/.$file
  mv ~/.$file $olddir/.$file
  echo "Creating symlink to $file in home directory."
  echo rm -f ~/.$file
  rm -f ~/.$file
  ls -ldg ~/.$file
  echo ln -sf $dir/$file ~/.$file
  ln -sf $dir/$file ~/.$file
done

mkdir -p ~/.config
mkdir -p $olddir/config
for file in ./config/*; do
  echo ln -sf ~/dotfiles/config/$(basename $file) ~/.config/$(basename $file)
  rm -rf ~/.config/$(basename $file)
  ln -sf ~/dotfiles/config/$(basename $file) ~/.config/$(basename $file)
done
