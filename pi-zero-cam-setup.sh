#!/bin/bash
set -e  # Exit immediately on any error

echo "=== Updating system and installing dependencies ==="

# Update and upgrade system
sudo apt update
sudo apt upgrade -y

# Install camera and streaming packages
sudo apt install -y raspi-utils-core curl uv4l uv4l-raspicam uv4l-raspicam-extras uv4l-server uv4l-webrtc-armv6

# Add UV4L repository key
curl -s http://www.linux-projects.org/listing/uv4l_repo/lpkey.asc | sudo apt-key add - || true

# Add UV4L repository
echo "deb http://www.linux-projects.org/listing/uv4l_repo/raspbian/stretch stretch main" | sudo tee /etc/apt/sources.list.d/uv4l.list

sudo apt update

echo "=== Dependencies installed ==="#!/bin/bash
set -e  # Exit immediately on any error

echo "=== Updating system and installing dependencies ==="

# Update and upgrade system
sudo apt update
sudo apt upgrade -y

# Install camera and streaming packages (replace libraspberrypi-bin with raspi-utils-core)
sudo apt install -y raspi-utils-core curl uv4l uv4l-raspicam uv4l-raspicam-extras uv4l-server uv4l-webrtc-armv6

# Add UV4L repository key
curl -s http://www.linux-projects.org/listing/uv4l_repo/lpkey.asc | sudo apt-key add - || true

# Add UV4L repository
echo "deb http://www.linux-projects.org/listing/uv4l_repo/raspbian/stretch stretch main" | sudo tee /etc/apt/sources.list.d/uv4l.list

sudo apt update

echo "=== Dependencies installed ==="
