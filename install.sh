#!/bin/bash

export INSTALL_PWD=`pwd`

########## Variables
. ~/dotfiles/install-scripts/lib/platform.sh

cd $INSTALL_PWD
source ./install-scripts/prerequisites.sh

##########

cd $INSTALL_PWD
source ./install-scripts/install-security.sh
cd $INSTALL_PWD
source ./install-scripts/install-zsh.sh
cd $INSTALL_PWD
source ./install-scripts/install-dotfiles.sh
cd $INSTALL_PWD
source ./install-scripts/install-bin.sh
cd $INSTALL_PWD
source ./install-scripts/install-node.sh
cd $INSTALL_PWD
source ./install-scripts/install-lsp.sh
cd $INSTALL_PWD
source ./install-scripts/install-vim.sh
cd $INSTALL_PWD
source ./install-scripts/install-emacs.sh

ln -sf ~/Dropbox/credentials/slack-term ~/.slack-term
#cd $INSTALL_PWD
#source ./install-scripts/install-docker.sh
#echo "ANGULAR/TYPESCRIPT"
#cd $INSTALL_PWD
#source ./install-scripts/install-ng.sh

