#!/bin/bash

# Direction: "next" or "prev"
direction="$1"

# Get active workspaces sorted by ID (number)
mapfile -t active_workspaces < <(hyprctl workspaces -j | jq 'sort_by(.id) | map(select(.windows > 0)) | .[].id')

# Get current workspace ID
current_ws=$(hyprctl activeworkspace -j | jq '.id')

# Find index of current workspace in the active list
index=-1
for i in "${!active_workspaces[@]}"; do
  if [[ "${active_workspaces[$i]}" == "$current_ws" ]]; then
    index=$i
    break
  fi
done

# If current workspace not found (shouldn't happen), default to first
[[ $index -eq -1 ]] && index=0

# Determine target index
if [[ "$direction" == "next" ]]; then
  next_index=$(((index + 1) % ${#active_workspaces[@]}))
elif [[ "$direction" == "prev" ]]; then
  next_index=$(((index - 1 + ${#active_workspaces[@]}) % ${#active_workspaces[@]}))
else
  echo "Usage: $0 [next|prev]"
  exit 1
fi

# Get workspace ID from target index
target_ws=${active_workspaces[$next_index]}

# Switch to target workspace
hyprctl dispatch workspace "$target_ws"
