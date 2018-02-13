#!/bin/bash

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

echo "installing prerequisites $platform"
if [[ $platform == 'linux' ]]; then
  PACKAGES_TO_INSTALL= \
    build-essential \
    speedtest-cli \
    source-highlight \
    zsh \
    vim \
    cmake \
    vim-youcompleteme \
    python-dev \
    libboost-all-dev \
    tmux \
    curl \
    ruby-dev \
    ctags \
    screenfetch \
    net-tools \
    neofetch \
    fonts-font-awesome \
    urlview


  sudo apt-get install -y $PACKAGES_TO_INSTALL
  echo ...nodejs
  curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
  sudo apt-get update
  sudo apt-get -y dist-upgrade
  sudo apt-get install -y nodejs
  npm config set prefix '/usr/local'
  sudo mkdir -p $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
  sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
  chsh -s $(which zsh)
elif [[ $platform == 'macos' ]]; then
  echo ...nodejs
  brew install neofetch
  # brew install nodejs etc
fi

##########

# create dotfiles_old in homedir
dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="inputrc profile bash_profile bashrc bash_aliases vimrc vim zlogin zshrc zprofile zshenv Xresources ctags tmux tmux.conf ackrc ideavimrc agignore eslintrc.js"    # list of files/folders to symlink in homedir

#echo "Creating $olddir for backup of any existing dotfiles in ~"
#mkdir -p $olddir
#rm -rf $olddir/*
#echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

sudo mkdir -p /etc/dnsmasq.d
sudo cp dnsmasq.conf /etc/dnsmasq.conf
sudo cp dnsmasq.hosts.conf /etc/dnsmasq.d/

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
