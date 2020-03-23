#!/bin/sh

HOSTNAME=`hostname`
FULLNAME=`getent passwd "${USER}" | cut -d ':' -f 5`
CPU=`cat /proc/cpuinfo | grep "model name" | uniq | sed -e 's/model name.*: //'`
CORES=`cat /proc/cpuinfo | grep "model name" | wc -l`
MEMORY=`free -ht | head -2 | tail -1 | awk '{print $2}'`

wget --quiet -O /tmp/modus_neofetch https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch
chmod 755 /tmp/modus_neofetch
/tmp/modus_neofetch --stdout --backend off --bold off --color_blocks off --ascii_bold off| tee /tmp/modus_info.txt
rm /tmp/modus_neofetch

echo "SYSTEM INFORMATION" | tee -a /tmp/modus_info.txt
echo "------------------" | tee -a /tmp/modus_info.txt
echo "HOST   ${HOSTNAME}" | tee -a /tmp/modus_info.txt
echo "USER   ${USER} (${FULLNAME})" | tee -a /tmp/modus_info.txt
echo "CPU    $CPU $CORES CORES" | tee -a /tmp/modus_info.txt
echo "MEMORY ${MEMORY}" | tee -a /tmp/modus_info.txt

echo "" | tee -a /tmp/modus_info.txt
echo "DISKS" | tee -a /tmp/modus_info.txt
echo "-----" | tee -a /tmp/modus_info.txt
df -h | head -1 | tee -a /tmp/modus_info.txt
df -h | sort -u -t ' ' -u -k 1,1 | grep ^/dev/ | tee -a /tmp/modus_info.txt

echo "" | tee -a /tmp/modus_info.txt
echo "NETWORK SPEED" | tee -a /tmp/modus_info.txt
echo "-------------" | tee -a /tmp/modus_info.txt
wget --quiet -O /tmp/modus_speedtest.py https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
chmod 755 /tmp/modus_speedtest.py
/tmp/modus_speedtest.py --simple | tee -a /tmp/modus_info.txt
rm /tmp/modus_speedtest.py

