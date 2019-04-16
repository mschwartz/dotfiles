#!/bin/sh

mkdir -p ~/tmp
cd ~/tmp
echo "=========> DD disk write"
dd if=/dev/zero of=tempfile bs=1M count=1024 conv=fdatasync,notrunc status=progress | tail -1 2>&1
echo "=========> DD disk read"
sudo sh -c "/usr/bin/echo 3 > /proc/sys/vm/drop_caches"
dd if=tempfile of=/dev/null bs=1M count=1024 status=progress | tail -1 2>&1
echo "=========> DD disk cache read"
dd if=tempfile of=/dev/null bs=1M count=1024 status=progress | tail -1 2>&1

rm ~/tmp/tempfile

#echo "=========> HDPARM"
#hdparm -Tt /dev/nvme0n1


