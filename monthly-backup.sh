#!/bin/bash

. ~/dotfiles/install-scripts/lib/platform.sh

if [[ $platform != "linux" ]]; then
  echo "Backup for Linux only"
  exit 1
fi

sudo mount /backup

echo "MONTHLY BACKUP"
tar -cvjf /backup/monthly/monthly_$(date +%Y%m%d).tar.bz2 /backup/daily
