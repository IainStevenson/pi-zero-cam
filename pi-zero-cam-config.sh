#!/bin/bash
set -e

echo "Creating systemd service for camera server..."

SERVICE_FILE="/etc/systemd/system/pi-zero-cam.service"

sudo tee "$SERVICE_FILE" > /dev/null <<'EOF'
[Unit]
Description=Pi Zero MJPEG Camera Server
After=network.target

[Service]
Type=simple
User=pi
WorkingDirectory=/home/pi/pi-zero-cam
ExecStart=/usr/bin/python3 /home/pi/pi-zero-cam/pi_zero_cam.py
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

sudo chmod 644 "$SERVICE_FILE"

echo "Service file created at $SERVICE_FILE"