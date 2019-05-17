#!/bin/bash

echo ">>> INSTALLING NFS"

. ~/dotfiles/install-scripts/lib/platform.sh

$HOSTNAME=`hostname`
if [[ $platform == 'arch' ]]; then
  sudo pacman --noconfirm -S nfs-utils sshfs cronie autofs
  sudo systemctl enable nfs-server
  sudo systemctl start nfs-server
  sudo systemctl enable cronie
  sudo systemctl start cronie
  sudo chmod 666 /etc/exports
  sudo echo "/home/mschwartz 192.168.0.0/24(rw,insecure,no_subtree_check,async,all_squash,anonuid=1000,anongid=1000)" >/etc/exports
  if [[ $HOSTNAME == "bigmoney" ]]; then
    sudo echo "/ssd/backups 192.168.0.0/24(rw,insecure,sync,no_subtree_check,no_root_squash)" >> /etc/exports
  fi
  sudo chmod 644 /etc/exports
  sudo exportfs -arv
  showmount -e
  echo ">>> Installing backup cron tasks"
  if [[ $HOSTNAME != "bigmoney" ]]; then
    crontab -l > /tmp/crontmp
    sed -i '/backup/d' /tmp/crontmp
    echo "* * * 2 0 $HOME/dotfiles/cron/daily-backup.sh" >>/tmp/crontmp
    echo "0 * * 3 0 $HOME/dotfiles/cron/weekly-backup.sh" >>/tmp/crontmp
    echo "* * 1 4 0 $HOME/dotfiles/cron/monthly-backup.sh" >>/tmp/crontmp
    crontab /tmp/crontmp
    rm /tmp/crontmp
  fi
fi
