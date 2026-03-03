#!/bin/bash
set -e

echo "Updating system..."
sudo apt update
sudo apt full-upgrade -y

echo "Installing required packages..."
sudo apt install -y \
    libcamera-apps \
    mediamtx \
    python3 \
    python3-pip \
    python3-flask \
    unclutter \
    feh \
    x11-xserver-utils

echo "Enabling camera interface..."
sudo raspi-config nonint do_camera 0

echo "Setup complete."