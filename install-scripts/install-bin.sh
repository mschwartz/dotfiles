#!/bin/bash

figlet "Install bin"
rm -rf $HOME/dotfiles/bin/node_modules
mkdir -p $HOME/bin
for bin in `ls $HOME/dotfiles/bin`; do
    ln -sf $HOME/dotfiles/bin/$bin $HOME/bin/$bin
done
ln -sf $HOME/dotfiles/install-scripts/lib $HOME/bin/lib

