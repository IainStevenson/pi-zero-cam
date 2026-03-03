#!/bin/bash
set -e

echo "Invoking device-setup.sh ..."

echo "Performing APT installs ..."
./pi-zero-cam-install.sh

echo "Configuring services ..."
./pi-zero-cam-config.sh

echo "Starting services ..."
./pi-zero-cam-services.sh