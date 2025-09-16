#!/bin/bash

# HDMI Auto-detection and Setup Script for i3wm
# Automatically configures HDMI display when connected

# Display configuration
LAPTOP_DISPLAY="eDP-1"
HDMI_DISPLAY="HDMI-1-0"
LAPTOP_RESOLUTION="2560x1600"
LAPTOP_RATE="240.00"
LAPTOP_DPI="120"

# Check if HDMI is connected
HDMI_STATUS=$(xrandr | grep "$HDMI_DISPLAY" | grep " connected")

if [ -n "$HDMI_STATUS" ]; then
    echo "HDMI display detected, configuring dual monitor setup..."
    
    # Get the best resolution for HDMI display
    HDMI_RESOLUTION=$(xrandr | grep -A1 "$HDMI_DISPLAY connected" | tail -n1 | awk '{print $1}')
    
    # If no resolution found, use a common fallback
    if [ -z "$HDMI_RESOLUTION" ]; then
        HDMI_RESOLUTION="1920x1080"
    fi
    
    # Configure dual monitor setup (extend to the right)
    xrandr --output "$LAPTOP_DISPLAY" --mode "$LAPTOP_RESOLUTION" --rate "$LAPTOP_RATE" --dpi "$LAPTOP_DPI" --primary \
           --output "$HDMI_DISPLAY" --mode "$HDMI_RESOLUTION" --right-of "$LAPTOP_DISPLAY" --auto
    
    # Set wallpaper on both displays
    feh --bg-fill /home/sud/.dotfiles/wallpapers/k2.jpg
    
    # Move mouse to primary display
    xdotool mousemove 1280 800
    
    # Restart i3bar to recognize new display
    i3-msg restart
    
    echo "Dual monitor setup completed: $LAPTOP_DISPLAY + $HDMI_DISPLAY"
    
    # Optional: Send notification
    if command -v notify-send &> /dev/null; then
        notify-send "Display Setup" "HDMI monitor connected and configured" -t 3000
    fi
    
else
    echo "HDMI display not connected, using laptop display only..."
    
    # Ensure laptop display is properly configured
    xrandr --output "$LAPTOP_DISPLAY" --mode "$LAPTOP_RESOLUTION" --rate "$LAPTOP_RATE" --dpi "$LAPTOP_DPI" --primary
    
    # Turn off HDMI output if it was previously connected
    xrandr --output "$HDMI_DISPLAY" --off
    
    # Set wallpaper
    feh --bg-fill /home/sud/.dotfiles/wallpapers/k2.jpg
fi

# Fix any potential workspace issues
i3-msg 'workspace 1; workspace 1'
