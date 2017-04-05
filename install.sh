#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

type=`uname -m`
dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="path profile bash_profile bashrc bash_aliases vimrc vim zlogin zshrc zprofile zshenv functions.zsh ctags tmux tmux.conf ackrc ideavimrc agignore"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    echo mv ~/.$file $olddir/.$file
    mv ~/.$file $olddir/.$file
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

rm -rf $HOMEdotfiles/bin/node_modules
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
cd ../YouCompleteMe
if [ "$type" = "armv71" ]; then
    export YCM_CORES=1
    YCM_CORES=1 ./install.py --tern-completer --system-boost
else
    ./install.py --tern-completer --system-boost
fi

