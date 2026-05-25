#!/bin/bash

# Rofi Dynamic Wallpaper Updater
# Updates the Rofi background image with a random wallpaper

WALLPAPER_DIR="$HOME/Pictures/Wallpapers/"
CACHE_FILE="$HOME/.cache/rofi-wallpaper.jpg"
LAST_WALLPAPER_FILE="$HOME/.cache/rofi-last-wallpaper"
LOCK_FILE="$HOME/.cache/rofi-wallpaper.lock"

# Check if script is already running
if [ -f "$LOCK_FILE" ]; then
  # Check if the process is actually running
  if ps -p $(cat "$LOCK_FILE") >/dev/null 2>&1; then
    echo "Wallpaper update already in progress"
    exit 0
  else
    # Stale lock file, remove it
    rm -f "$LOCK_FILE"
  fi
fi

# Create lock file with current PID
echo $ >"$LOCK_FILE"

# Cleanup function to remove lock file
cleanup() {
  rm -f "$LOCK_FILE"
}
trap cleanup EXIT

# Function to select and copy a random wallpaper
update_wallpaper() {
  # Get a random wallpaper from the directory
  wallpaper=$(fd -e png -e jpg -e jpeg -e webp . "$WALLPAPER_DIR" | shuf -n1)

  # Check if a wallpaper was found
  if [ -z "$wallpaper" ]; then
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
  fi

  # Check if it's the same as last time (try to get variety)
  if [ -f "$LAST_WALLPAPER_FILE" ]; then
    last_wallpaper=$(cat "$LAST_WALLPAPER_FILE")

    # If same, try to get a different one (max 3 attempts)
    attempts=0
    while [ "$wallpaper" = "$last_wallpaper" ] && [ $attempts -lt 3 ]; do
      wallpaper=$(fd -e png -e jpg -e jpeg -e webp . "$WALLPAPER_DIR" | shuf -n1)
      attempts=$((attempts + 1))
    done
  fi

  # Copy wallpaper to cache location (atomic operation)
  cp "$wallpaper" "${CACHE_FILE}.tmp" && mv "${CACHE_FILE}.tmp" "$CACHE_FILE"

  # Save for next comparison
  echo "$wallpaper" >"$LAST_WALLPAPER_FILE"

  echo "Updated Rofi wallpaper: $(basename "$wallpaper")"
}

# Main execution
update_wallpaper
