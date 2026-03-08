#!/bin/bash
set -e

echo "Creating systemd services for camera server..."

SERVICE_FILE1="/etc/systemd/system/pi-zero-cam-streaming.service"

sudo tee "$SERVICE_FILE1" > /dev/null <<'EOF'
[Unit]
Description=Pi Camera Streaming Server
After=network.target

[Service]
Type=simple
ExecStart=/home/zero/scripts/start-streaming.sh
User=zero
WorkingDirectory=/home/zero/scripts
StandardOutput=inherit
StandardError=inherit
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF


sudo chmod 644 "$SERVICE_FILE1"
echo "Streaming service file created at $SERVICE_FILE1"


SERVICE_FILE2="/etc/systemd/system/pi-zero-cam-http.service"


sudo tee "$SERVICE_FILE2" > /dev/null <<'EOF'
[Unit]
Description=Pi Zero MJPEG Camera http Server
After=network.target

[Service]
Type=simple
User=zero
WorkingDirectory=/home/zero/scripts
ExecStart=/usr/bin/python3 /home/zero/scripts/pi-zero-cam.py
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF


sudo chmod 644 "$SERVICE_FILE2"
echo "Http service file created at $SERVICE_FILE2"

