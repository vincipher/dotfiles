#!/bin/bash

filename="$HOME/Pictures/Screenshots/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

if [ "$1" = "area" ]; then
  grim -g "$(slurp)" "$filename"
else
  grim "$filename"
fi

# Copy to clipboard
wl-copy <"$filename"

# notify
notify-send "📸 Screenshot saved to clipboard"
