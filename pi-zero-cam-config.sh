#!/bin/bash
set -e

echo "Creating camera stream service..."

sudo tee /etc/systemd/system/pi-zero-cam-stream.service > /dev/null <<EOF
[Unit]
Description=Pi Zero Camera Stream
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash -c '
source /usr/local/bin/pi-zero-cam-vars.sh;
libcamera-vid \
    --width \$WIDTH \
    --height \$HEIGHT \
    --framerate \$FPS \
    --bitrate \$BITRATE \
    --brightness \$BRIGHTNESS \
    --contrast \$CONTRAST \
    --exposure \$EXPOSURE \
    -t 0 \
    --inline \
    -o rtsp://127.0.0.1:8554/cam'
Restart=always
RestartSec=2

[Install]
WantedBy=multi-user.target
EOF

echo "Creating conditional display service..."

sudo tee /etc/systemd/system/pi-zero-cam-display.service > /dev/null <<EOF
[Unit]
Description=Pi Zero Conditional Fullscreen Viewer
After=graphical.target pi-zero-cam-stream.service
Requires=pi-zero-cam-stream.service

[Service]
User=pi
Environment=DISPLAY=:0
ExecStart=/bin/bash -c '
if xrandr | grep " connected" > /dev/null; then
    unclutter -idle 0.1 &
    feh --fullscreen --auto-zoom rtsp://127.0.0.1:8554/cam
fi'
Restart=always
RestartSec=5

[Install]
WantedBy=graphical.target
EOF

echo "Creating HTTP control service..."

sudo tee /usr/local/bin/pi-zero-cam-http.py > /dev/null <<'EOF'
#!/usr/bin/env python3
from flask import Flask, request
import subprocess

app = Flask(__name__)

VARS_FILE = "/usr/local/bin/pi-zero-cam-vars.sh"

def update_profile(profile):
    subprocess.run(
        ["sed", "-i", f"s/^PROFILE=.*/PROFILE=\"{profile}\"/", VARS_FILE],
        check=True
    )
    subprocess.run(["systemctl", "restart", "pi-zero-cam-stream"], check=True)

@app.route("/")
def control():
    profile = request.args.get("profile")
    if profile:
        update_profile(profile)
        return f"Profile switched to {profile}\n"

    return "Camera running\n"

app.run(host="0.0.0.0", port=80)
EOF

sudo chmod +x /usr/local/bin/pi-zero-cam-http.py

sudo tee /etc/systemd/system/pi-zero-cam-http.service > /dev/null <<EOF
[Unit]
Description=Pi Zero Camera HTTP Control
After=network.target

[Service]
ExecStart=/usr/bin/python3 /usr/local/bin/pi-zero-cam-http.py
Restart=always
RestartSec=2

[Install]
WantedBy=multi-user.target
EOF

sudo cp pi-zero-cam-vars.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/pi-zero-cam-vars.sh

sudo systemctl daemon-reload

echo "Configuration complete."