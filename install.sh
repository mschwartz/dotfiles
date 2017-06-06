#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

type=`uname -m`
unamestr=`uname`
platform='unknown'
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'armv7' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='macos'
fi

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="path profile bash_profile bashrc bash_aliases vimrc vim zlogin zshrc zprofile zshenv functions.zsh ctags tmux tmux.conf ackrc ideavimrc agignore"    # list of files/folders to symlink in homedir

echo "installing prerequisites $platform"
if [[ $platform == 'linux' ]]; then
    echo ...nodejs
    curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
    sudo apt-get update
    sudo apt-get -y dist-upgrade
    sudo apt-get install -y nodejs
    npm config set prefix '/usr/local'
    sudo mkdir -p $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
    sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
    #sudo chown mschwartz.mschwartz /usr/local /usr/local/bin /usr/local/lib
    sudo apt-get install -y build-essential speedtest-cli zsh vim cmake vim-youcompleteme python-dev libboost-all-dev
elif [[ $platform == 'macos' ]]; then
    echo ...nodejs
    # brew install nodejs etc
fi

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
    rm -rf $olddir
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
if [[ "$platform" == "macos" ]]; then
    cd ../YouCompleteMe
    if [ "$type" = "armv71" ]; then
        export YCM_CORES=1
        YCM_CORES=1 ./install.py --tern-completer --system-boost
    else
        ./install.py --tern-completer --system-boost
    fi
fi

