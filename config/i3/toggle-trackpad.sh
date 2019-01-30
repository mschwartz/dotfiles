#!/bin/bash
tp=`xinput list --name-only | grep -i TouchPad`

TPadState=`xinput --list-props "$tp"|grep "Device Enabled"|tail -c -2`
#MouseState=`xinput --list-props "$mouse"|grep "Device Enabled"|tail -c -2`

if [ "$TPadState" = "1" ];
then
        `xinput --set-prop "$tp" "Device Enabled" 0`
	TPadState+=$(xinput --list-props "$tp"|grep "Device Enabled"|tail -c -2)
        notify-send -t 2000 "TouchPad disabled!"
else
        `xinput --set-prop "$tp" "Device Enabled" 1`
	TPadState+=$(xinput --list-props "$tp"|grep "Device Enabled"|tail -c -2)
        notify-send -t 2000 "TouchPad enabled!"
fi

