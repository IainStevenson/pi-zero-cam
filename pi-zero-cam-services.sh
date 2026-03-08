#!/bin/bash
set -e


echo "configuring systemd services..."

# Reload systemd to recognize new service
sudo systemctl daemon-reload


# Enable service at boot
sudo systemctl enable pi-zero-cam-streaming.service
# Start service immediately
sudo systemctl start pi-zero-cam-streaming.service
echo "Pi Zero Camera streaming service started. Check with:"
echo "  systemctl status pi-zero-cam-streaming.service"



# Enable service at boot
#sudo systemctl enable pi-zero-cam.service
# Start service immediately
#sudo systemctl start pi-zero-cam.service
#echo "Pi Zero Camera service started. Check with:"
#echo "  systemctl status pi-zero-cam.service"



# Optional: follow logs
sudo journalctl -u pi-zero-cam-streaming.service -f