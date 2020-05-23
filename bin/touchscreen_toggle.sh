#!/bin/bash

# touchpad_device_id=$(xinput list | grep -i Touchpad | sed -e "s/^[^=]*=//; s/[ \t].*$//")
touchscreen_device_id="Melfas LGDisplay Incell Touch"

#        Device Enabled (143):   0
touchscreen_state() {
    xinput list-props "${touchscreen_device_id}" | grep "Device Enabled" | sed -e "s/^[^:]*:[ 	]*//"
}

if [[ "$(touchscreen_state)" == "0" ]]; then
  xinput enable "${touchscreen_device_id}"
  notify-send -t 1000 "Touchscreen enabled" "$(touchscreen_state)"
else
  xinput disable "${touchscreen_device_id}"
  notify-send -t 10000 "Touchscreen disabled" "$(touchscreen_state) Windows-S to reenable"
fi

