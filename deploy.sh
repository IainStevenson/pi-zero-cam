#!/bin/bash
set -e
echo "Before deployment ensure the device is flashed and booted as required"
echo "Obtain its operational IP address"
# -------------------------------
# CONFIGURATION - edit as needed
# -------------------------------
PI_USER="pi"             # Raspberry Pi username
PI_HOST=""   # Prompted below if empty
REMOTE_DIR="~/scripts"   # Remote folder to copy payload
PAYLOAD_DIR="."          # Local folder with scripts

# -------------------------------
# PROMPT FOR HOST IF EMPTY
# -------------------------------
if [ -z "$PI_HOST" ]; then
    read -p "Enter Raspberry Pi IP or hostname: " PI_HOST
fi

# -------------------------------
# CREATE REMOTE SCRIPTS FOLDER
# -------------------------------
echo "Creating remote scripts folder on $PI_USER@$PI_HOST..."
ssh "$PI_USER@$PI_HOST" "mkdir -p $REMOTE_DIR"

# -------------------------------
# COPY ALL FILES IN PAYLOAD_DIR
# -------------------------------
echo "Copying payload files to $PI_USER@$PI_HOST:$REMOTE_DIR ..."
scp "$PAYLOAD_DIR"/* "$PI_USER@$PI_HOST:$REMOTE_DIR/"

scp pi-zero-cam.py pi_zero_cam_vars.py pi-zero-cam-setup.sh pi-zero-cam-config.sh pi-zero-cam-services.sh  $DEST_USER@$DEST_HOST:~/$DEST_DIR/

# -------------------------------
# SET EXECUTABLE PERMISSIONS ON .sh FILES
# -------------------------------
echo "Setting executable permissions for .sh files..."
ssh "$PI_USER@$PI_HOST" "chmod +x $REMOTE_DIR/*.sh"

echo "Deploy complete!"