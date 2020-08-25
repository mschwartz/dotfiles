#!/bin/sh

sleep 1
# disable right trackpad button on machines that have one
if [ -e /usr/bin/synclient ]; then
  synclient TapButton1=0
  synclient TapButton2=0
  synclient VertScrollDelta=-113
  synclient PalmDetect=1
else
  touchpad=`xinput list --name-only | grep -i TouchPad`
  trackpoint=`xinput list --name-only | grep -i TrackPoint`

  xinput --set-prop "$touchpad" "libinput Accel Speed" .5
#  xinput --set-prop "$touchpad" "libinput Accel Speed Default" .5
  xinput --set-prop "$touchpad" "libinput Natural Scrolling Enabled" 1
#  xinput --set-prop "$touchpad" "libinput Natural Scrolling Enabled Default" 1
  xinput --set-prop "$touchpad" "libinput Tapping Enabled" 0
#  xinput --set-prop "$touchpad" "libinput Tapping Enabled Default" 0
  # disable trackpoint
  xinput --set-prop "$trackpoint" "Device Enabled" 0
fi
