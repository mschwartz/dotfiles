#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform != "linux" ]]; then 
  if [[ $platform != "arch" ]]; then
    echo "Backup for Linux only"
    exit 1
  fi
fi


HOSTNAME=`hostname`
sudo mount /backup
sudo mkdir -p /backup/$HOSTNAME/weekly
echo "WEEKLY BACKUP"
echo "*** Backing up /etc"
sudo rsync -av --delete  /backup/$HOSTNAME/daily/etc /backup/weekly/etc
echo "*** Backing up /opt"
sudo rsync -av --delete  /backup/$HOSTNAME/daily/opt /backup/weekly/opt
echo "*** Backing up /var"
sudo rsync -av --delete  /backup/$HOSTNAME/daily/var /backup/weekly/var
echo "*** Backing up /usr/local"
sudo rsync -av --delete  /backup/$HOSTNAME/daily/user.local /backup/weekly/user.local
echo "*** Backing up /home"
sudo rsync -av --delete  /backup/$HOSTNAME/daily/home /backup/weekly/home
