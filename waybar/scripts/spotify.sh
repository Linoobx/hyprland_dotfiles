#!/bin/bash

player_status=$(playerctl -p spotify status 2>/dev/null)

if [ "$player_status" = "Playing" ]; then
	artist=$(playerctl -p spotify metadata artist)
	title=$(playerctl -p spotify metadata title)
	echo "  $artist - $title"
elif [ "$player_status" = "Paused" ]; then
	artist=$(playerctl -p spotify metadata artist)
	title=$(playerctl -p spotify metadata title)
	echo "  $artist - $title"
else
	echo ""
	exit
fi

max_length=30

if [ ${#text} -gt $max_length ]; then
    text="$text    $text"
    scroll_pos=$(( $(date +%s) % ${#text} ))
    echo "${text:$scroll_pos:$max_length}"
else
    echo "$text"
fi
