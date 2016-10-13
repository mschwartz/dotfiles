#!/bin/sh

mkdir -p $HOME/snowdog/github
mkdir-p $HOME/snowdog/projects

sshfs mschwartz@snowdog:sencha/github $HOME/snowdog/github -ocache=no,nolocalcache,volname=snowdog,defer_permissions,reconnect
sshfs mschwartz@snowdog:sencha/projects $HOME/snowdog/projects -ocache=no,nolocalcache,volname=snowdog,defer_permissions,reconnect

