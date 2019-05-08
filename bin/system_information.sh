#!/bin/sh

HOSTNAME=`hostname`
FULLNAME=`getent passwd "${USER}" | cut -d ':' -f 5`
CPU=`cat /proc/cpuinfo | grep "model name" | uniq | sed -e 's/model name.*: //'`
CORES=`cat /proc/cpuinfo | grep "model name" | wc -l`
MEMORY=`free -ht | head -2 | tail -1 | awk '{print $2}'`

echo "SYSTEM INFORMATION"
echo "------------------"
echo "HOST   ${HOSTNAME}"
echo "USER   ${USER} (${FULLNAME})"
echo "CPU    $CPU $CORES CORES"
echo "MEMORY ${MEMORY}"
echo ""
echo "DISKS"
echo "-----"
df -h | head -1
df -h | sort -u -t ' ' -u -k 1,1 | grep ^/dev/
#df -h | grep ^/dev/
echo ""
echo "NETWORK SPEED"
echo "-------------"
wget -o /tmp/foo --output-document=/dev/null --report-speed=bits http://speedtest.wdc01.softlayer.com/downloads/test500.zip
chmod 777 /tmp/foo
FOO=`cat /tmp/foo | tail -4 | head -1 | sed -e 's/^.*=//' | sed -e 's/s.*$//'`
SECONDS=`cat /tmp/foo | tail -4 | head -1 | sed -e 's/^.*=//' | sed -e 's/s.*$//'`
SPEED=`expr 512000000 / $SECONDS / 1024 / 1024`
echo "$SPEED MBYTES/SEC DOWNLOAD (downloaded 500MB in $SECONDS seconds)"
rm /tmp/foo
#foo=`command foo`
#echo $foo

