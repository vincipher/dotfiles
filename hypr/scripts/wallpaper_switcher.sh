#!/bin/bash

wallpaper_dir="$HOME/Pictures/wallpapers"

# Get a random wallpaper
random_wall=$(find "$wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)

# Ensure one was found
if [[ -z "$random_wall" ]]; then
  echo "No wallpapers found in $wallpaper_dir"
  exit 1
fi

# Apply the wallpaper using swww with animation
swww img "$random_wall" \
  --transition-type any \
  --transition-pos 0.5,0.5 \
  --transition-fps 60 \
  --transition-step 80
