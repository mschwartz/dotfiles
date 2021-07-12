#!/bin/sh

source ~/dotfiles/install-scripts/lib/platform.sh

echo "bash language server"
npm i -g bash-language-server

echo "cmake language server"
sudo pip install cmake-language-server

echo "Dockerfile language server"
npm install -g dockerfile-language-server-nodejs

echo "html language server"
npm install -g vscode-langservers-extracted

echo "JSON langauge server"
npm install -g vscode-langservers-extracted

echo "python language server"
sudo pip install python-language-server

echo "typescript language server"
npm install -g typescript typescript-language-server

echo "vim language server"
npm install -g vim-language-server

echo "yaml language server"
npm install -g yaml-language-server

echo 'markdown language server'
npm install -g instant-markdown-d
