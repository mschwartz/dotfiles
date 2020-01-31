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
echo "Mounted /backup"
sudo mkdir -p /backup/$HOSTNAME/daily
echo "made /backup/$HOSTNAME/daily"
echo "*** Backing up /etc"
sudo rsync -avzO --exclude node_modules --exclude .cache --exclude .snapshots --delete /etc/ /backup/$HOSTNAME/daily/etc
echo "*** Backing up /opt"
sudo rsync -avzO --exclude node_modules --exclude .cache --exclude .snapshots --delete /opt/ /backup/$HOSTNAME/daily/opt
echo "*** Backing up /var"
sudo rsync -avzO --exclude node_modules --exclude .cache --exclude .snapshots --delete /var/ /backup/$HOSTNAME/daily/var
echo "*** Backing up /usr/local"
sudo rsync -avzO --exclude node_modules --exclude .cache --exclude .snapshots --delete /usr/local/ /backup/$HOSTNAME/daily/usr.local
echo "*** Backing up /home"
sudo rsync -avzO --exclude node_modules --exclude .cache --exclude .snapshots --delete /home/ /backup/$HOSTNAME/daily/home
