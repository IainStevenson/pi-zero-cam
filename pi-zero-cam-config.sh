#!/bin/bash
set -e

# Update apt and install dependencies
sudo apt update
sudo apt install -y python3 python3-pip libcamera-apps gstreamer1.0-tools gstreamer1.0-plugins-base gstreamer1.0-plugins-good

# Create scripts folder if not exists
mkdir -p "$HOME/scripts"

# Make camera server executable
chmod +x "$HOME/scripts/pi-zero-cam.py"

# Create systemd service
SERVICE_FILE="$HOME/.config/systemd/user/pi-zero-camera.service"
mkdir -p "$(dirname "$SERVICE_FILE")"

cat > "$SERVICE_FILE" <<EOF
[Unit]
Description=Pi Zero Camera Auto
After=graphical.target network.target

[Service]
Type=simple
ExecStartPre=/bin/sleep 5
ExecStart=/usr/bin/python3 $HOME/scripts/pi-zero-cam.py
Restart=always
StandardOutput=journal
StandardError=journal
User=pi

[Install]
WantedBy=default.target
EOF