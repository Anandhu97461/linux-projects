#!/bin/bash

# ---------- CONFIG ----------
DISK="/dev/sdb"
PART1="${DISK}1"
PART2="${DISK}2"
MOUNT1="/mnt/data1"
MOUNT2="/mnt/data2"
FS1="ext4"
FS2="xfs"
FSTAB="/etc/fstab"
# ----------------------------

# Function to print colored output
print_color() {
  local color="$1"
  local message="$2"
  local nc='\033[0m'
  case "$color" in
    "green") code='\033[0;32m' ;;
    "red") code='\033[0;31m' ;;
    "yellow") code='\033[1;33m' ;;
    *) code="$nc" ;;
  esac
  echo -e "${code}${message}${nc}"
}

# Install required package for xfs
if ! command -v mkfs.xfs &>/dev/null; then
  print_color yellow "Installing xfsprogs package..."
  sudo apt install -y xfsprogs
fi

# Unmount and cleanup if already mounted
sudo umount $PART1 &>/dev/null
sudo umount $PART2 &>/dev/null

# Partition the disk (if not already)
if [ ! -b "$PART2" ]; then
  print_color green "Creating partitions on $DISK..."
  sudo parted -s "$DISK" mklabel gpt
  sudo parted -s "$DISK" mkpart primary "$FS1" 1MiB 3GiB
  sudo parted -s "$DISK" mkpart primary "$FS2" 3GiB 100%
  sudo partprobe "$DISK"
else
  print_color yellow "Partitions already exist on $DISK. Skipping partitioning."
fi

# Format partitions
print_color green "Formatting $PART1 as $FS1..."
sudo mkfs."$FS1" -F "$PART1"

print_color green "Formatting $PART2 as $FS2..."
sudo mkfs."$FS2" -f "$PART2"

# Create mount points
sudo mkdir -p "$MOUNT1"
sudo mkdir -p "$MOUNT2"

# Mount
print_color green "Mounting partitions..."
sudo mount "$PART1" "$MOUNT1"
sudo mount "$PART2" "$MOUNT2"

# Add to /etc/fstab (if not already)
if ! grep -q "$PART1" "$FSTAB"; then
  echo "$PART1 $MOUNT1 $FS1 defaults 0 2" | sudo tee -a "$FSTAB" > /dev/null
fi
if ! grep -q "$PART2" "$FSTAB"; then
  echo "$PART2 $MOUNT2 $FS2 defaults 0 2" | sudo tee -a "$FSTAB" > /dev/null
fi

print_color green "Partitioning, formatting, and mounting complete!"