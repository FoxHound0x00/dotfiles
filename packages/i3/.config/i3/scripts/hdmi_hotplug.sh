#!/bin/bash

# HDMI Hotplug Detection Script
# This script is called by udev when HDMI is connected/disconnected

# Wait a moment for the display to be fully recognized
sleep 2

# Get the current user and display
USER_NAME="sud"
DISPLAY=":0"
XAUTHORITY="/home/$USER_NAME/.Xauthority"

# Export environment variables
export DISPLAY="$DISPLAY"
export XAUTHORITY="$XAUTHORITY"

# Run the HDMI setup script as the correct user
sudo -u "$USER_NAME" /home/sud/.config/i3/scripts/hdmi_setup.sh

# Log the event
echo "$(date): HDMI hotplug event processed" >> /tmp/hdmi_hotplug.log
