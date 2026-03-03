echo "Invoking device-setup.sh ..."
echo "performing APT isntalls ..."
./pi-zero-cam-install.sh
echo "Configuring services ..."
./pi-zero-cam-config.sh
echo "Starting services ..."
./pi-zero-cam-services.sh