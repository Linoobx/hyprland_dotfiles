#!/bin/bash

powered=$(bluetoothctl show | grep "Powered: yes")
connected=$(bluetoothctl devices Connected | head -1)

if [ -z "$powered" ]; then
    echo "󰂲"
elif [ -n "$connected" ]; then
    device_name=$(echo "$connected" | cut -d ' ' -f 3-)
    echo "󰂱"
else
    echo "󰂯"
fi
