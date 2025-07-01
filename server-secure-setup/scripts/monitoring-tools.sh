#!/bin/bash

# Print in color
print_color() {
  NC='\033[0m'
  case "$1" in
    "green") COLOR='\033[0;32m' ;;
    "red") COLOR='\033[0;31m' ;;
    "yellow") COLOR='\033[1;33m' ;;
    *) COLOR=$NC ;;
  esac
  echo -e "${COLOR}$2${NC}"
}

print_color green "Installing monitoring tools..."

sudo apt update
sudo apt install -y sysstat htop ncdu

print_color green "Enabling sysstat (iostat/pidstat)..."
sudo sed -i 's/^ENABLED="false"/ENABLED="true"/' /etc/default/sysstat
sudo systemctl enable sysstat
sudo systemctl restart sysstat

print_color green "Running basic performance diagnostics..."

print_color yellow "Disk usage in /var:"
du -sh /var/*

print_color yellow "Filesystem disk usage:"
df -h

print_color yellow "I/O statistics:"
iostat

print_color yellow "Process-level I/O stats:"
pidstat -d 1 3

print_color yellow "Top-like resource usage:"
htop || print_color red "htop not found or failed to run."

print_color green "Simulating disk I/O load with dd..."
dd if=/dev/zero of=/tmp/testfile bs=1M count=1024 oflag=dsync status=progress
rm -f /tmp/testfile

print_color green "Monitoring setup complete!"
