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
sudo mkdir -p /backup/$HOSTNAME/monthly
echo "MONTHLY BACKUP"
tar -cvjf /backup/$HOSTNAME/monthly/monthly_$(date +%Y%m%d).tar.bz2 /backup/daily
