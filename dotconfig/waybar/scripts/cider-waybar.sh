#!/usr/bin/env bash

# Set the update interval (in seconds)
interval=5

# Define the module function
function waybar_module {
  # Retrieve the currently playing track's artist and title from Cider using DBus
  metadata=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.cider /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:"org.mpris.MediaPlayer2.Player" string:"Metadata" | grep -Ev "^method" | tail -n 1 | awk '{gsub(/^[[:space:]]+|[[:space:]]+$/, ""); print}')

  # Display the metadata
  echo -e "{\"text\":\"$metadata\"}"
}

# Continuously update the module
while true; do
  waybar_module
  sleep $interval
done
