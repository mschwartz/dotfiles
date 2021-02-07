#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform != "linux" ]]; then 
  if [[ $platform != "arch" ]]; then
    echo "Backup for Linux only"
    exit 1
  fi
fi


HOSTNAME=`hostname`
echo "WEEKLY BACKUP"
#function cleanup {
#  sudo umount /backup
#  echo "Unmounted /backup"
#}
#trap cleanup EXIT

cd ~/dotfiles/cron
#sudo mount /backup
echo "WEEKLY BACKUP"
ssh admin@nas1 mkdir -p /volume1/NetBackup/$HOSTNAME/weekly
echo "made $HOSTNAME/weekly"
ssh admin@nas1 rsync -av /volume1/NetBackup/$HOSTNAME/daily/ /volume1/$HOSTNAME/weekly/

#echo "*** Backing up /etc"
#sudo rsync -avzzO --exclude-from=excludes.rsync --delete  /backup/$HOSTNAME/daily/etc /backup/weekly/etc
#echo "*** Backing up /opt"
#sudo rsync -avzzO --exclude-from=excludes.rsync --delete  /backup/$HOSTNAME/daily/opt /backup/weekly/opt
#echo "*** Backing up /var"
#sudo rsync -avzzO --exclude-from=excludes.rsync --delete  /backup/$HOSTNAME/daily/var /backup/weekly/var
#echo "*** Backing up /usr/local"
#sudo rsync -avzzO --exclude-from=excludes.rsync --delete  /backup/$HOSTNAME/daily/user.local /backup/weekly/user.local
#echo "*** Backing up /home"
#sudo rsync -avzzO --exclude-from=excludes.rsync --delete  /backup/$HOSTNAME/daily/home /backup/weekly/home
