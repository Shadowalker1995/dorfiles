#!/bin/bash
if xinput list 14 | grep "This device is disabled" ; then
    xinput set-prop 14 "Device Enabled" 1 ;
else
    xinput set-prop 14 "Device Enabled" 0 ;
fi
