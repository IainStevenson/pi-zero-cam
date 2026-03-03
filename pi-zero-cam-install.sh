#!/bin/bash
set -e

echo "Updating system apt packages..."
sudo apt update
sudo apt full-upgrade -y

echo "Installing required packages..."
sudo apt install -y python3 python3-pip
sudo apt install -y rpicam-apps

echo "Enabling camera interface..."
sudo raspi-config nonint do_camera 0

echo "Setup complete."