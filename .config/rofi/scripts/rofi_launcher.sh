#!/bin/bash

# Rofi Launcher with Dynamic Wallpaper
# Updates wallpaper before launching Rofi

# Check if Rofi is already running
if pgrep -x "rofi" >/dev/null; then
  echo "Rofi is already running"
  exit 0
fi

# Check if cache file exists, if not run update synchronously first time
if [ ! -f "$HOME/.cache/rofi-wallpaper.jpg" ]; then
  echo "First run - initializing wallpaper cache..."
  ~/.config/rofi/scripts/rofi_wallpaper.sh
else
  # Update wallpaper in background (with lock file protection)
  ~/.config/rofi/scripts/rofi_wallpaper.sh &
  # Small delay to let wallpaper update (non-blocking)
  sleep 0.1
fi

# Launch Rofi
rofi -show drun -config ~/.config/rofi/config.rasi
