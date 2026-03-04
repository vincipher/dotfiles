#!/bin/bash

output="$HOME/Videos/recording_$(date +%Y-%m-%d_%H-%M-%S).mp4"
pidfile="/tmp/wf-recorder.pid"

# If already recording, stop it
if [ -f "$pidfile" ]; then
  kill "$(cat "$pidfile")"
  rm "$pidfile"
  notify-send "⏹️ Screen recording stopped."
else
  # Start recording based on mode
  if [ "$1" = "area" ]; then
    wf-recorder -g "$(slurp)" -f "$output" &
  else
    wf-recorder -f "$output" &
  fi

  echo $! >"$pidfile"
  notify-send "🔴 Screen recording started."
fi
