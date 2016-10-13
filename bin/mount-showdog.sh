#!/bin/sh

OPTIONS=reconnect,follow_symlinks
mkdir -p $HOME/snowdog/github
mkdir -p $HOME/snowdog/projects

sshfs mschwartz@snowdog:sencha/github $HOME/snowdog/github -o$OPTIONS -ovolname="github"
sshfs mschwartz@snowdog:sencha/projects $HOME/snowdog/projects -o$OPTIONS -ovolname="projects"

