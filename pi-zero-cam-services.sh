#!/bin/bash
set -e

sudo systemctl enable mediamtx
sudo systemctl enable pi-zero-cam-stream
sudo systemctl enable pi-zero-cam-http
sudo systemctl enable pi-zero-cam-display

sudo systemctl restart mediamtx
sudo systemctl restart pi-zero-cam-stream
sudo systemctl restart pi-zero-cam-http
sudo systemctl restart pi-zero-cam-display

echo "All services started."