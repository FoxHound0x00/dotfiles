#!/bin/bash

# Mirror laptop display to HDMI (clone mode)

LAPTOP_DISPLAY="eDP-1"
HDMI_DISPLAY="HDMI-1-0"
LAPTOP_RESOLUTION="2560x1600"
LAPTOP_RATE="240.00"
LAPTOP_DPI="120"

# Check if HDMI is connected
HDMI_STATUS=$(xrandr | grep "$HDMI_DISPLAY" | grep " connected")

if [ -n "$HDMI_STATUS" ]; then
    # Find common resolution between displays
    # For mirroring, we'll use a resolution that both displays support
    COMMON_RESOLUTION="1920x1080"  # Safe fallback
    
    # Try to find the highest common resolution
    LAPTOP_RESOLUTIONS=$(xrandr | grep -A20 "$LAPTOP_DISPLAY connected" | grep -E "^\s+[0-9]+x[0-9]+" | awk '{print $1}')
    HDMI_RESOLUTIONS=$(xrandr | grep -A20 "$HDMI_DISPLAY connected" | grep -E "^\s+[0-9]+x[0-9]+" | awk '{print $1}')
    
    # Find highest common resolution (simple approach)
    for res in $LAPTOP_RESOLUTIONS; do
        if echo "$HDMI_RESOLUTIONS" | grep -q "$res"; then
            COMMON_RESOLUTION="$res"
            break
        fi
    done
    
    # Configure mirrored display
    xrandr --output "$LAPTOP_DISPLAY" --mode "$COMMON_RESOLUTION" --dpi "$LAPTOP_DPI" --primary \
           --output "$HDMI_DISPLAY" --mode "$COMMON_RESOLUTION" --same-as "$LAPTOP_DISPLAY"
    
    # Set wallpaper
    feh --bg-fill /home/sud/.dotfiles/wallpapers/k2.jpg
    
    echo "Mirrored display configured: $COMMON_RESOLUTION on both displays"
    
    # Send notification
    if command -v notify-send &> /dev/null; then
        notify-send "Display Setup" "Mirroring to HDMI display ($COMMON_RESOLUTION)" -t 3000
    fi
    
else
    echo "HDMI display not connected!"
    if command -v notify-send &> /dev/null; then
        notify-send "Display Error" "HDMI display not connected" -t 3000 -u critical
    fi
    exit 1
fi
