#!/bin/bash
set -e

# Load camera variables (optional if needed in future scripts)
source ./pi-zero-cam-vars.sh

echo "=== Enabling and starting services ==="

# Enable services at boot
sudo systemctl enable camera-kiosk.service
sudo systemctl enable uv4l.service

# Start services immediately
sudo systemctl start camera-kiosk.service
sudo systemctl start uv4l.service

# Disable screen blanking for local display
xset s off
xset -dpms
xset s noblank

echo "=== Services started ==="
echo "Local fullscreen camera running."
echo "Remote access: http://<pi-ip>:$UV4L_PORT/"
