#!/bin/bash

# Function to print colored output
print_color() {
  case $1 in
    "green") COLOR='\033[0;32m' ;;
    "red")   COLOR='\033[0;31m' ;;
    *)       COLOR='\033[0m' ;;
  esac
  NC='\033[0m'
  echo -e "${COLOR}$2${NC}"
}

# Check if UFW is installed
if ! command -v ufw &>/dev/null; then
  print_color red "UFW is not installed. Installing..."
  sudo apt update && sudo apt install -y ufw
fi

# Allow SSH on custom port
sudo ufw allow 2222/tcp
print_color green "Allowed SSH on port 2222"

# Set default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing
print_color green "Set default firewall policies"

# Enable UFW if not already enabled
if ! sudo ufw status | grep -q "Status: active"; then
  sudo ufw --force enable
  print_color green "UFW firewall is now enabled"
else
  print_color green "UFW was already enabled"
fi

# Show final status
print_color green "Current UFW Rules:"
sudo ufw status numbered

