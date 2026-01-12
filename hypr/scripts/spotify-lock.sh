#!/bin/bash
if pgrep spotify > /dev/null; then
    playerctl -p spotify metadata --format "  {{ artist }} - {{ title }}" 2>/dev/null
fi
