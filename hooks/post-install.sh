#!/bin/bash
# This script will copy the systemd service and the bash script into the image's filesystem.
# The first argument to the hook is the root path of the image.
ROOT_PATH=$1

echo "Copying first-run service and script to image..."

# Create the necessary directories inside the image.
mkdir -p "$ROOT_PATH/etc/systemd/system"
mkdir -p "$ROOT_PATH/usr/local/bin"

# Download the service file directly into the image's systemd directory (one-liner).
wget -O "$ROOT_PATH/etc/systemd/system/my-first-run.service" "https://raw.githubusercontent.com/porfiriopaiz/fzt-eib-configs/refs/heads/fix/root-config/etc/systemd/system/my-first-run.service"

# Download the bash script directly into the image's local bin directory (one-liner).
wget -O "$ROOT_PATH/usr/local/bin/my-first-run.sh" "https://raw.githubusercontent.com/porfiriopaiz/fzt-eib-configs/refs/heads/fix/root-config/usr/local/bin/my-first-run.sh"

# Enable the service for the next boot.
# Note: The systemd daemon itself is not running during this hook. This command
# simply creates the necessary symlink for the service to be enabled on the
# first real boot of the system.
ln -s "$ROOT_PATH/etc/systemd/system/my-first-run.service" "$ROOT_PATH/etc/systemd/system/multi-user.target.wants/"

echo "First-run service enabled."