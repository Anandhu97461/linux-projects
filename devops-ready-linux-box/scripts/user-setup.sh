#!/bin/bash

# -----------------------------
# Function: print_color
# Usage: print_color "green" "message"
# -----------------------------
print_color() {
  NC='\033[0m' # No Color
  case "$1" in
    "green") COLOR='\033[0;32m' ;;  # Success
    "red")   COLOR='\033[0;31m' ;;  # Error
    "yellow") COLOR='\033[1;33m' ;; # Warning/Info
    *) COLOR="$NC" ;;
  esac
  echo -e "${COLOR}$2${NC}"
}

# -----------------------------
# Step 1: Create user if not exists
# -----------------------------
if id "devopsadmin" &>/dev/null; then
  print_color "yellow" "User 'devopsadmin' already exists. Skipping user creation."
else
  sudo adduser devopsadmin
  print_color "green" "User 'devopsadmin' created successfully."
fi

# -----------------------------
# Step 2: Add user to 'sudo' group (Ubuntu default)
# -----------------------------
sudo usermod -aG sudo devopsadmin
print_color "green" "User 'devopsadmin' added to the 'sudo' group."

# -----------------------------
# Step 3: Create sudoers file for passwordless sudo
# -----------------------------
sudo bash -c 'echo "devopsadmin ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/devopsadmin'
sudo chmod 440 /etc/sudoers.d/devopsadmin
print_color "green" "Passwordless sudo access configured via /etc/sudoers.d/devopsadmin."

# -----------------------------
# Step 4: Lock the root account
# -----------------------------
sudo passwd --lock root
print_color "green" "Root account has been locked for security."

