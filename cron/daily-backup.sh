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
#  sudo umount /backup
  echo "Unmounted /backup"
}
trap cleanup EXIT

cd ~/dotfiles/cron
#sudo mount /backup
#echo "Mounted /backup"
sudo mkdir -p /backup/$HOSTNAME/daily
echo "made /backup/$HOSTNAME/daily"
echo "*** Backing up /etc"
ssh nas1 mkdir -p /volume1/NetBackup/$HOSTNAME/daily/etc
sudo rsync -av -e "ssh -l mschwartz -i ~mschwartz/.ssh/id_rsa" --exclude-from=excludes.rsync --delete /etc/ admin@nas1:/volume1/NetBackup/$HOSTNAME/daily/etc
#sudo rsync -av -e "ssh -l mschwartz" --exclude-from=excludes.rsync --delete /etc/ mschwartz@nas1::NetBackup/$HOSTNAME/daily/etc
echo "*** Backing up /opt"
ssh nas1 mkdir -p /volume1/NetBackup/$HOSTNAME/daily/opt
sudo rsync -av -e "ssh -l mschwartz -i ~mschwartz/.ssh/id_rsa" --exclude-from=excludes.rsync --delete /opt/ admin@nas1:/volume1/NetBackup/$HOSTNAME/daily/opt
#sudo rsync -avz --exclude-from=excludes.rsync --delete /opt/ mschwartz@nas1:$HOSTNAME/daily/opt
echo "*** Backing up /var"
ssh nas1 mkdir -p /volume1/NetBackup/$HOSTNAME/daily/var
sudo rsync -av -e "ssh -l mschwartz -i ~mschwartz/.ssh/id_rsa" --exclude-from=excludes.rsync --delete /var/ admin@nas1:/volume1/NetBackup/$HOSTNAME/daily/var
#sudo rsync -avz --exclude-from=excludes.rsync --delete /var/ mschwartz@nas1:$HOSTNAME/daily/var
echo "*** Backing up /usr/local"
ssh nas1 mkdir -p /volume1/NetBackup/$HOSTNAME/daily/usr.local
sudo rsync -av -e "ssh -l mschwartz -i ~mschwartz/.ssh/id_rsa" --exclude-from=excludes.rsync --delete /usr/local/ admin@nas1:/volume1/NetBackup/$HOSTNAME/daily/usr.local
#sudo rsync -avz --exclude-from=excludes.rsync --delete /usr/local/ mschwartz@nas1:$HOSTNAME/daily/usr.local
echo "*** Backing up /home"
ssh nas1 mkdir -p /volume1/NetBackup/$HOSTNAME/daily/home
sudo rsync -av \
  -e "ssh -l mschwartz -i ~mschwartz/.ssh/id_rsa" \
  --exclude=".cache" \
  --exclude=".snapshots" \
  --exclude="node_modules" \
  --exclude-from=excludes.rsync \
  --delete \
  /home/ admin@nas1:/volume1/NetBackup/$HOSTNAME/daily/home
#echo sudo rsync -av -e "ssh -l mschwartz" --exclude-from=excludes.rsync --delete /home/ mschwartz@nas1::NetBackup/$HOSTNAME/daily/home
#sudo rsync -av -e "ssh -l mschwartz" --exclude-from=excludes.rsync --delete /home/ mschwartz@nas1::NetBackup/$HOSTNAME/daily/home
#echo sudo rsync -av -e "ssh -l mschwartz" --exclude-from=excludes.rsync --delete /etc/ mschwartz@nas1::NetBackup/$HOSTNAME/daily/etc
