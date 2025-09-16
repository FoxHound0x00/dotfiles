#!/bin/bash

# Use HDMI display only (turn off laptop display)

LAPTOP_DISPLAY="eDP-1"
HDMI_DISPLAY="HDMI-1-0"

# Check if HDMI is connected
HDMI_STATUS=$(xrandr | grep "$HDMI_DISPLAY" | grep " connected")

if [ -n "$HDMI_STATUS" ]; then
    # Get the best resolution for HDMI display
    HDMI_RESOLUTION=$(xrandr | grep -A1 "$HDMI_DISPLAY connected" | tail -n1 | awk '{print $1}')
    
    # If no resolution found, use a common fallback
    if [ -z "$HDMI_RESOLUTION" ]; then
        HDMI_RESOLUTION="1920x1080"
    fi
    
    # Configure HDMI only (turn off laptop display)
    xrandr --output "$LAPTOP_DISPLAY" --off \
           --output "$HDMI_DISPLAY" --mode "$HDMI_RESOLUTION" --primary --auto
    
    # Set wallpaper
    feh --bg-fill /home/sud/.dotfiles/wallpapers/k2.jpg
    
    # Move all workspaces to HDMI display
    for i in {1..10}; do
        i3-msg "workspace $i; move workspace to output $HDMI_DISPLAY"
    done
    
    # Go back to workspace 1
    i3-msg 'workspace 1'
    
    echo "HDMI-only display configured: $HDMI_RESOLUTION"
    
    # Send notification
    if command -v notify-send &> /dev/null; then
        notify-send "Display Setup" "Using HDMI display only ($HDMI_RESOLUTION)" -t 3000
    fi
    
else
    echo "HDMI display not connected!"
    if command -v notify-send &> /dev/null; then
        notify-send "Display Error" "HDMI display not connected" -t 3000 -u critical
    fi
    exit 1
fi
