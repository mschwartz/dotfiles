#!/bin/bash

[[ $BLOCK_BUTTON = "1" ]] && st -e w3m wttr.in/92211?u

ping -q -w 1 -c 1 `ip r | grep default | cut -d ' ' -f 3` >/dev/null || exit

curl --silent wttr.in/92211?u > ~/.weatherreport

echo -n ☔ $(cat ~/.weatherreport | sed -n 16p | sed -e 's/[^m]*m//g' | grep -o "[0-9]*%" | sort -n | sed -e '$!d')
 
cat ~/.weatherreport | sed -n 13p | sed -e 's/[^m]*m//g;s/[^0-9]/ /g;s/ /\n/g;/^s*$/d' | grep [0-9] | sort -n | sed -e 1b -e '$!d' | tr '\n' ' ' | awk '{print " ❄️",$1 "°","☀️",$2 "°"}'
