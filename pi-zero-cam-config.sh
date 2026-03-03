#!/bin/bash
set -e

# Load camera variables
source ./pi-zero-cam-vars.sh

echo "=== Creating systemd service files with camera variables ==="

# -----------------------------
# Local fullscreen camera viewer
# -----------------------------
cat << EOF | sudo tee /etc/systemd/system/camera-kiosk.service
[Unit]
Description=Pi Camera Fullscreen Viewer
After=graphical.target

[Service]
User=$DISPLAY_USER
Environment=DISPLAY=:0
ExecStart=/usr/bin/nohup /usr/bin/rpicam-vid -t 0 --fullscreen \
           --brightness $CAM_BRIGHTNESS --contrast $CAM_CONTRAST --exposure $CAM_EXPOSURE > /home/$DISPLAY_USER/camera.log 2>&1
Restart=always
WorkingDirectory=/home/$DISPLAY_USER

[Install]
WantedBy=graphical.target
EOF

# -----------------------------
# UV4L streaming service
# -----------------------------
cat << EOF | sudo tee /etc/systemd/system/uv4l.service
[Unit]
Description=UV4L Camera Streaming Service
After=network.target

[Service]
ExecStart=/usr/bin/uv4l --driver raspicam --auto-video_nr \
           --server-option=--port=$UV4L_PORT \
           --server-option=--enable-server \
           --server-option=--editable-config-file=/etc/uv4l/uv4l-raspicam.conf \
           --brightness=$CAM_BRIGHTNESS --contrast=$CAM_CONTRAST --exposure=$CAM_EXPOSURE
Restart=always
User=root
WorkingDirectory=/home/$DISPLAY_USER

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd to register new services
sudo systemctl daemon-reload

echo "=== Service files created ==="
