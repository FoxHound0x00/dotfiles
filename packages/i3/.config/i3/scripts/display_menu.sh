#!/bin/bash

# Interactive Display Management Menu for i3wm
# Provides a dmenu interface for display configuration

# Display configuration
LAPTOP_DISPLAY="eDP-1"
HDMI_DISPLAY="HDMI-1-0"

# Check if HDMI is connected
HDMI_STATUS=$(xrandr | grep "$HDMI_DISPLAY" | grep " connected")

if [ -n "$HDMI_STATUS" ]; then
    # HDMI is connected - show all options
    MENU_OPTIONS="Extend (Laptop + HDMI)\nMirror (Clone displays)\nHDMI Only\nLaptop Only\nDetect & Auto-configure"
else
    # HDMI not connected - show limited options
    MENU_OPTIONS="Laptop Only\nDetect & Auto-configure"
fi

# Show dmenu and get user selection
CHOICE=$(echo -e "$MENU_OPTIONS" | dmenu -i -p "Display Setup:")

case "$CHOICE" in
    "Extend (Laptop + HDMI)")
        ~/.config/i3/scripts/hdmi_extend.sh
        ;;
    "Mirror (Clone displays)")
        ~/.config/i3/scripts/hdmi_mirror.sh
        ;;
    "HDMI Only")
        ~/.config/i3/scripts/hdmi_only.sh
        ;;
    "Laptop Only")
        ~/.config/i3/scripts/laptop_only.sh
        ;;
    "Detect & Auto-configure")
        ~/.config/i3/scripts/hdmi_setup.sh
        ;;
    *)
        exit 0
        ;;
esac
