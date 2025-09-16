#!/bin/bash

# Extend laptop display to HDMI (dual monitor setup)

LAPTOP_DISPLAY="eDP-1"
HDMI_DISPLAY="HDMI-1-0"
LAPTOP_RESOLUTION="2560x1600"
LAPTOP_RATE="240.00"
LAPTOP_DPI="120"

# Check if HDMI is connected
HDMI_STATUS=$(xrandr | grep "$HDMI_DISPLAY" | grep " connected")

if [ -n "$HDMI_STATUS" ]; then
    # Get the best resolution for HDMI display
    HDMI_RESOLUTION=$(xrandr | grep -A1 "$HDMI_DISPLAY connected" | tail -n1 | awk '{print $1}')
    
    # If no resolution found, use a common fallback
    if [ -z "$HDMI_RESOLUTION" ]; then
        HDMI_RESOLUTION="1920x1080"
    fi
    
    # Configure extended display (HDMI to the right of laptop)
    xrandr --output "$LAPTOP_DISPLAY" --mode "$LAPTOP_RESOLUTION" --rate "$LAPTOP_RATE" --dpi "$LAPTOP_DPI" --primary \
           --output "$HDMI_DISPLAY" --mode "$HDMI_RESOLUTION" --right-of "$LAPTOP_DISPLAY" --auto
    
    # Set wallpaper on both displays
    feh --bg-fill /home/sud/.dotfiles/wallpapers/k2.jpg
    
    # Move mouse to primary display
    xdotool mousemove 1280 800
    
    echo "Extended display configured: $LAPTOP_DISPLAY + $HDMI_DISPLAY ($HDMI_RESOLUTION)"
    
    # Send notification
    if command -v notify-send &> /dev/null; then
        notify-send "Display Setup" "Extended to HDMI display" -t 3000
    fi
    
else
    echo "HDMI display not connected!"
    if command -v notify-send &> /dev/null; then
        notify-send "Display Error" "HDMI display not connected" -t 3000 -u critical
    fi
    exit 1
fi
