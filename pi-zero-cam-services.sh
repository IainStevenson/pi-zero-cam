#!/bin/bash
set -e
echo "Enabling and Starting systemd services ..."

# Enable and start user-level systemd service
sudo systemctl daemon-reload
sudo systemctl enable pi-zero-camera.service
sudo systemctl start pi-zero-camera.service

echo "Pi Zero Camera service started. Check with:"
echo "  systemctl status pi-zero-camera.service"
# Watch logs
sudo journalctl -u pi-zero-cam.service -f