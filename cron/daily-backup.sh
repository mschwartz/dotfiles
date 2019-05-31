#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform != "linux" ]]; then 
  if [[ $platform != "arch" ]]; then
    echo "Backup for Linux only"
    exit 1
  fi
fi

HOSTNAME=`hostname`
echo "DAILY BACKUP"
sudo mount /backup
sudo mkdir -p /backup/$HOSTNAME/daily
echo "*** Backing up /etc"
sudo rsync -avO --delete /etc/ /backup/$HOSTNAME/daily/etc
echo "*** Backing up /opt"
sudo rsync -avO --delete /opt/ /backup/$HOSTNAME/daily/opt
echo "*** Backing up /var"
sudo rsync -avO --delete /var/ /backup/$HOSTNAME/daily/var
echo "*** Backing up /usr/local"
sudo rsync -avO --delete /usr/local/ /backup/$HOSTNAME/daily/usr.local
echo "*** Backing up /home"
sudo rsync -avO --delete /home/ /backup/$HOSTNAME/daily/home
