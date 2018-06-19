#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform != "linux" ]]; then
  echo "Backup for Linux only"
  exit 1
fi

sudo mount /backup

echo "WEEKLY BACKUP"
echo "*** Backing up /etc"
sudo rsync -av --delete  /backup/daily/etc /backup/weekly/etc
echo "*** Backing up /opt"
sudo rsync -av --delete  /backup/daily/opt /backup/weekly/opt
echo "*** Backing up /var"
sudo rsync -av --delete  /backup/daily/var /backup/weekly/var
echo "*** Backing up /usr/local"
sudo rsync -av --delete  /backup/daily/user.local /backup/weekly/user.local
echo "*** Backing up /home"
sudo rsync -av --delete  /backup/daily/home /backup/weekly/home
