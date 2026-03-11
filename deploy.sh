#!/bin/bash
set -e
: '
 Get a working mediamtx headless pi based camera operational
'


PI_USER="zero" 
PI_HOST="zero-cam.my.lan" 


copy_config(){
    echo "Copying mediamtx configuration file $PI_USER@$PI_HOST: home folder"
    scp *.yml "$PI_USER@$PI_HOST:~/"
}

update_device(){

    echo "Updating system apt packages..."
    ssh "$PI_USER@$PI_HOST" 'sudo apt update'
    echo "Getting nala..."
    ssh "$PI_USER@$PI_HOST" 'sudo apt install -y nala'
    ssh "$PI_USER@$PI_HOST" 'sudo nala fetch --auto -y'
    echo "Updating system apt packages..."
    ssh "$PI_USER@$PI_HOST" 'sudo nala update'
    echo "Installing required packages..."
    ssh "$PI_USER@$PI_HOST" 'sudo nala install -y rpicam-apps'
    echo "Enabling camera interface..."
    ssh "$PI_USER@$PI_HOST" 'sudo raspi-config nonint do_camera 0'
}
install_mediamtx(){
    echo "Installing mediamtx from released tarball"
    ssh "$PI_USER@$PI_HOST" 'mkdir -p ~/mediamtx-install'
    ssh "$PI_USER@$PI_HOST" 'cd ~/mediamtx-install && wget https://github.com/bluenviron/mediamtx/releases/download/v1.16.3/mediamtx_v1.16.3_linux_arm64.tar.gz && tar -xvf mediamtx_v1.16.3_linux_arm64.tar.gz && echo "Installing mediamtx to the system path" &&    sudo mv mediamtx /usr/local/bin/' 
}

configure_service(){
    echo "Creating systemd services for camera server..."

    

    ssh "$PI_USER@$PI_HOST" 'sudo tee /etc/systemd/system/pi-zero-cam-streaming.service > /dev/null <<'EOF'
[Unit]
Description=Pi Zero Camera Streaming Server
After=network-online.target
Wants=network-online.target

[Service]
User=zero
Group=video
WorkingDirectory=/home/zero

# Wait until the camera device is ready
ExecStartPre=sleep 8

# Start MediaMTX with explicit config
ExecStart=mediamtx /home/zero/mediamtx.yml

# Restart if it crashes
Restart=always
RestartSec=5

# Optional: limit resources to prevent runaway
CPUQuota=90%
#MemoryMax=200M

[Install]
WantedBy=multi-user.target
EOF'

    ssh "$PI_USER@$PI_HOST" 'sudo chmod 644 /etc/systemd/system/pi-zero-cam-streaming.service'
    echo "Streaming service file created at /etc/systemd/system/pi-zero-cam-streaming.service"


    echo "configuring systemd services..."

    # Reload systemd to recognize new service
    ssh "$PI_USER@$PI_HOST" 'sudo systemctl daemon-reload'
    # Enable service at boot
    ssh "$PI_USER@$PI_HOST" 'sudo systemctl enable pi-zero-cam-streaming.service'
    # Start service immediately
    ssh "$PI_USER@$PI_HOST" 'sudo systemctl start pi-zero-cam-streaming.service'
    echo "Pi Zero Camera streaming service started. Check locally on the device with:"
    echo "  systemctl status pi-zero-cam-streaming.service"

}


watch_service_log(){
    ssh "$PI_USER@$PI_HOST" 'sudo journalctl -u pi-zero-cam-streaming.service -f'
}


update_device()
install_mediamtx
copy_config
configure_service
echo "Deploy complete! Watching service startup. control-C when satisfied"
watch_service_log

