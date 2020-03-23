#!/bin/bash
tp=`xinput list --name-only | grep -i TouchPad`

TPadState=`xinput --list-props "$tp"|grep "Device Enabled"|tail -c -2`
#MouseState=`xinput --list-props "$mouse"|grep "Device Enabled"|tail -c -2`

`xinput --set-prop "$tp" "Device Enabled" 0`
`xinput --set-prop "$tp" "Device Enabled" 1`
notify-send -t 2000 "TouchPad reset!"

