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

function cleanup {
  sudo umount /backup
  echo "Unmounted /backup"
}
trap cleanup EXIT

cd ~/dotfiles/cron
sudo mount /backup
echo "Mounted /backup"
sudo mkdir -p /backup/$HOSTNAME/daily
echo "made /backup/$HOSTNAME/daily"
echo "*** Backing up /etc"
sudo rsync -avzzO --exclude-from=excludes.rsync --delete /etc/ /backup/$HOSTNAME/daily/etc
echo "*** Backing up /opt"
sudo rsync -avzzO --exclude-from=excludes.rsync --delete /opt/ /backup/$HOSTNAME/daily/opt
echo "*** Backing up /var"
sudo rsync -avzzO --exclude-from=excludes.rsync --delete /var/ /backup/$HOSTNAME/daily/var
echo "*** Backing up /usr/local"
sudo rsync -avzzO --exclude-from=excludes.rsync --delete /usr/local/ /backup/$HOSTNAME/daily/usr.local
echo "*** Backing up /home"
sudo rsync -avzzO --exclude-from=excludes.rsync --delete /home/ /backup/$HOSTNAME/daily/home
