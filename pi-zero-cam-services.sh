#!/bin/bash
set -e

echo "Enabling and starting systemd service..."

# Reload systemd to recognize new service
sudo systemctl daemon-reload

# Enable service at boot
sudo systemctl enable pi-zero-cam.service

# Start service immediately
sudo systemctl start pi-zero-cam.service

echo "Pi Zero Camera service started. Check with:"
echo "  systemctl status pi-zero-cam.service"

# Optional: follow logs
sudo journalctl -u pi-zero-cam.service -f