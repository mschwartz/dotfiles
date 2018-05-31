#!/bin/bash

INSTALL_PWD=`pwd`
########## Variables
. ./install-scripts/lib/platform.sh
source ./install-scripts/prerequisites.sh

##########

source ./install-scripts/install-dotfiles.sh
source ./install-scripts/install-bin.sh
source ./install-scripts/install-vim.sh


# oh my zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo cd $INSTALL_PWD
cd $INSTALL_PWD

echo "DOCKER"
source ./install-scripts/install-docker.sh
echo "ANGULAR/TYPESCRIPT"
source ./install-scripts/install-ng.sh

