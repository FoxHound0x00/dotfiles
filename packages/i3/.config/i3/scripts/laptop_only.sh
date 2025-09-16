#!/bin/bash

# Use laptop display only (turn off external displays)

LAPTOP_DISPLAY="eDP-1"
HDMI_DISPLAY="HDMI-1-0"
LAPTOP_RESOLUTION="2560x1600"
LAPTOP_RATE="240.00"
LAPTOP_DPI="120"

# Configure laptop display only
xrandr --output "$LAPTOP_DISPLAY" --mode "$LAPTOP_RESOLUTION" --rate "$LAPTOP_RATE" --dpi "$LAPTOP_DPI" --primary \
       --output "$HDMI_DISPLAY" --off

# Turn off any other connected displays
xrandr | grep " connected" | grep -v "$LAPTOP_DISPLAY" | awk '{print $1}' | while read output; do
    xrandr --output "$output" --off
done

# Set wallpaper
feh --bg-fill /home/sud/.dotfiles/wallpapers/k2.jpg

# Move all workspaces to laptop display
for i in {1..10}; do
    i3-msg "workspace $i; move workspace to output $LAPTOP_DISPLAY"
done

# Go back to workspace 1
i3-msg 'workspace 1'

echo "Laptop-only display configured: $LAPTOP_RESOLUTION @ ${LAPTOP_RATE}Hz"

# Send notification
if command -v notify-send &> /dev/null; then
    notify-send "Display Setup" "Using laptop display only" -t 3000
fi
