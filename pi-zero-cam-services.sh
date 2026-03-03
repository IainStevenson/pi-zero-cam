#!/bin/bash
set -e

# Enable and start user-level systemd service
systemctl --user daemon-reload
systemctl --user enable pi-zero-camera.service
systemctl --user start pi-zero-camera.service

echo "Pi Zero Camera service started. Check with:"
echo "  systemctl --user status pi-zero-camera.service"