#!/bin/bash
set -e

# Enable and start user-level systemd service
sudo systemctl --user daemon-reload
sudo systemctl --user enable pi-zero-camera.service
sudo systemctl --user start pi-zero-camera.service

echo "Pi Zero Camera service started. Check with:"
echo "  systemctl --user status pi-zero-camera.service"