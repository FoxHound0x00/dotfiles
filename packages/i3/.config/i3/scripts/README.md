# i3wm HDMI Display Configuration

## Overview
Complete HDMI display management for i3wm with automatic detection and manual controls.

## Features
- **Automatic HDMI detection** on i3 startup/restart
- **Manual display management** via keybindings
- **Workspace assignments** for dual monitor setup
- **Multiple display modes**: extend, mirror, HDMI-only, laptop-only
- **Optional hotplug detection** via udev rules

## Keybindings
- `$mod+p` - Display management menu (dmenu)
- `$mod+Shift+p` - Extend to HDMI (dual monitor)
- `$mod+Ctrl+p` - Mirror displays (clone mode)
- `$mod+Alt+p` - HDMI only
- `$mod+Ctrl+Alt+p` - Laptop only

## Workspace Layout
- **Workspaces 1-5**: Laptop display (eDP-1)
- **Workspaces 6-10**: HDMI display (HDMI-1-0) when connected

## Scripts
- `hdmi_setup.sh` - Auto-detection and configuration
- `display_menu.sh` - Interactive dmenu interface
- `hdmi_extend.sh` - Dual monitor setup (extend)
- `hdmi_mirror.sh` - Mirror/clone displays
- `hdmi_only.sh` - Use HDMI display only
- `laptop_only.sh` - Use laptop display only
- `hdmi_hotplug.sh` - Hotplug event handler

## Optional: Automatic Hotplug Detection
To enable automatic HDMI detection when plugging/unplugging:

```bash
sudo cp ~/.config/i3/scripts/99-hdmi-hotplug.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
```

## Configuration Details
- **Laptop**: 2560x1600 @ 240Hz, DPI 120
- **HDMI**: Auto-detected resolution, positioned right of laptop
- **Wallpaper**: Applied to all active displays
- **Notifications**: Desktop notifications for status updates

## Dependencies
- `xrandr` - Display configuration
- `feh` - Wallpaper management
- `xdotool` - Mouse positioning
- `notify-send` - Desktop notifications (optional)
- `dmenu` - Display menu interface

## Troubleshooting
- Check HDMI connection: `xrandr | grep HDMI-1-0`
- Manual setup: `~/.config/i3/scripts/hdmi_setup.sh`
- View logs: `tail -f /tmp/hdmi_hotplug.log` (if using hotplug)
