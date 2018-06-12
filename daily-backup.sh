#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform != "linux" ]]; then
  echo "Backup for Linux only"
  exit 1
fi

echo "DAILY BACKUP"
sudo mount /backup
echo "*** Backing up /etc"
sudo rsync -av --delete /etc/ /backup/daily/etc
echo "*** Backing up /opt"
sudo rsync -av --delete /opt/ /backup/daily/opt
echo "*** Backing up /var"
sudo rsync -av --delete /var/ /backup/daily/var
echo "*** Backing up /usr/local"
sudo rsync -av --delete /usr/local/ /backup/daily/usr.local
echo "*** Backing up /home"
sudo rsync -av --delete /home/ /backup/daily/home
