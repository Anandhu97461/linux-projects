#!/bin/bash

# Function: Colored output
print_color() {
  local color=$1
  local message=$2
  local NC='\033[0m'
  case $color in
    "green") COLOR='\033[0;32m' ;;
    "red") COLOR='\033[0;31m' ;;
    "yellow") COLOR='\033[1;33m' ;;
    *) COLOR='\033[0m' ;;
  esac
  echo -e "${COLOR}${message}${NC}"
}

print_color "green" "Installing performance monitoring tools..."

# Only install if not already present
sudo apt update

for pkg in sysstat htop ncdu iotop stress; do
  if ! dpkg -s "$pkg" &> /dev/null; then
    print_color "yellow" "Installing $pkg..."
    sudo apt install -y "$pkg"
  else
    print_color "green" "$pkg is already installed."
  fi
done

print_color "green" "Tools installed: sysstat, htop, ncdu, iotop, stress"

echo ""
print_color "green" "Running Disk & CPU Monitoring Commands..."

print_color "yellow" "iostat -dx 2 (press Ctrl+C to stop)"
iostat -dx 2 & sleep 5; kill $!

echo ""
print_color "yellow" "pidstat -d 2 (press Ctrl+C to stop)"
pidstat -d 2 & sleep 5; kill $!

echo ""
print_color "yellow" "du -sh /var/*"
du -sh /var/* | sort -hr | head -n 10

echo ""
print_color "green" "Running disk write performance test using dd..."
dd if=/dev/zero of=/mnt/data1/testfile bs=1M count=512 oflag=direct status=progress
rm /mnt/data1/testfile

echo ""
print_color "green" "Running stress test (30 seconds)..."
stress --cpu 2 --io 1 --vm 1 --vm-bytes 128M --timeout 30

echo ""
print_color "green" "Monitoring complete."

