#!/bin/bash

# touchpad_device_id=$(xinput list | grep -i Touchpad | sed -e "s/^[^=]*=//; s/[ \t].*$//")
touchpad_device_id="ETPS/2 Elantech Touchpad"

#        Device Enabled (143):   0
touchpad_state() {
    xinput list-props "${touchpad_device_id}" | grep "Device Enabled" | sed -e "s/^[^:]*:[ 	]*//"
}

if [[ "$(touchpad_state)" == "0" ]]; then
  xinput enable "${touchpad_device_id}"
  notify-send -t 1000 "Touchpad enabled" "$(touchpad_state)"
else
  xinput disable "${touchpad_device_id}"
  notify-send -t 30000 "Touchpad disabled" "$(touchpad_state) use Windows-T to enable"
fi

