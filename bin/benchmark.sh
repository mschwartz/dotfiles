#!/bin/sh

mkdir -p ~/tmp
cd ~/tmp
echo "=========> DD disk write"
dd if=/dev/zero of=tempfile bs=1M count=1024 conv=fdatasync,notrunc status=progress >out 2>&1
tail -1 out
echo "=========> DD disk read"
sudo sh -c "/usr/bin/echo 3 > /proc/sys/vm/drop_caches"
dd if=tempfile of=/dev/null bs=1M count=1024 status=progress >out 2>&1
tail -1 out
echo "=========> DD disk cache read"
dd if=tempfile of=/dev/null bs=1M count=1024 status=progress >out 2>&1
tail -1 out

rm ~/tmp/tempfile out

#echo "=========> HDPARM"
#hdparm -Tt /dev/nvme0n1


