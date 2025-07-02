#!/bin/bash

set -e  # Exit on any error

# Function for colored messages
print_color() {
  NC='\033[0m'  # No Color
  case $1 in
    "green") COLOR='\033[0;32m' ;;
    "red") COLOR='\033[0;31m' ;;
    "yellow") COLOR='\033[1;33m' ;;
    *) COLOR=$NC ;;
  esac
  echo -e "${COLOR}$2${NC}"
}

DISK="/dev/sdc"
VG="vgperf"
LV="lvdata"
MOUNT_POINT="/mnt/lvdata"

# Check if disk exists
if [ ! -b "$DISK" ]; then
  print_color red "Disk $DISK not found. Exiting."
  exit 1
fi

# Create PV
if sudo pvdisplay "$DISK" > /dev/null 2>&1; then
  print_color yellow "Physical Volume already exists on $DISK"
else
  print_color green "Creating Physical Volume on $DISK..."
  sudo pvcreate "$DISK"
fi

# Create VG
if sudo vgdisplay "$VG" > /dev/null 2>&1; then
  print_color yellow "Volume Group $VG already exists"
else
  print_color green "Creating Volume Group $VG..."
  sudo vgcreate "$VG" "$DISK"
fi

# Create LV
if sudo lvdisplay "/dev/${VG}/${LV}" > /dev/null 2>&1; then
  print_color yellow "Logical Volume $LV already exists"
else
  print_color green "Creating Logical Volume $LV..."
  sudo lvcreate -L 2G -n "$LV" "$VG"
fi

# Format LV
print_color green "Formatting LV with ext4..."
sudo mkfs.ext4 -F "/dev/${VG}/${LV}"

# Mount LV
print_color green "Mounting LV at $MOUNT_POINT..."
sudo mkdir -p "$MOUNT_POINT"
sudo mount "/dev/${VG}/${LV}" "$MOUNT_POINT"

# Add to fstab if not already present
FSTAB_LINE="/dev/${VG}/${LV} $MOUNT_POINT ext4 defaults 0 2"
if grep -Fxq "$FSTAB_LINE" /etc/fstab; then
  print_color yellow "fstab entry already exists"
else
  echo "$FSTAB_LINE" | sudo tee -a /etc/fstab > /dev/null
  print_color green "fstab updated for persistence"
fi

# Show result
print_color green "LVM mount status:"
df -h | grep "$MOUNT_POINT"

print_color green "LVM setup completed successfully!"
