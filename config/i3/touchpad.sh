#!/bin/sh

# disable right trackpad button on machines that have one
if [ -e /usr/bin/synclient ]; then
  echo "disabling tap'"
  synclient TapButton1=0
  synclient TapButton2=0
fi
