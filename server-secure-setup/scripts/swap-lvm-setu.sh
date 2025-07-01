#!/bin/bash

# Function to print colored output
print_color() {
  NC='\033[0m' # No Color
  case "$1" in
    "green") COLOR='\033[0;32m' ;;  # Success
    "red")   COLOR='\033[0;31m' ;;  # Error
    "blue")  COLOR='\033[0;34m' ;;  # Info
    *)       COLOR='\033[0m' ;;
  esac
  echo -e "${COLOR}$2${NC}"
}

print_color "blue" "Creating Physical Volume on /dev/sdb..."
sudo pvcreate /dev/sdb

print_color "blue" "Creating Volume Group 'vgdata'..."
sudo vgcreate vgdata /dev/sdb

print_color "blue" "Creating Logical Volume 'datalv' (5G) and formatting it as ext4..."
sudo lvcreate -L 5G -n datalv vgdata
sudo mkfs.ext4 /dev/vgdata/datalv

print_color "blue" "Mounting /dev/vgdata/datalv to /data..."
sudo mkdir -p /data
sudo mount /dev/vgdata/datalv /data
echo '/dev/vgdata/datalv /data ext4 defaults 0 2' | sudo tee -a /etc/fstab

print_color "blue" "Creating Logical Volume 'swaplv' (1G) and enabling swap..."
sudo lvcreate -L 1G -n swaplv vgdata
sudo mkswap /dev/vgdata/swaplv
sudo swapon /dev/vgdata/swaplv
echo '/dev/vgdata/swaplv none swap sw 0 0' | sudo tee -a /etc/fstab

print_color "green" "LVM and Swap configuration completed successfully."

print_color "blue" "Verifying mounts and swap..."
mount | grep /data
swapon --show

