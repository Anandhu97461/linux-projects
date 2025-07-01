#!/bin/bash

# =============================
# SSH Hardening Script
# =============================

# -------- Color Print Function --------
function print_color() {
    local color=$1
    local message=$2
    local NC='\033[0m'  # No Color

    case $color in
        "green") COLOR='\033[0;32m' ;;
        "red")   COLOR='\033[0;31m' ;;
        "yellow") COLOR='\033[1;33m' ;;
        *) COLOR=$NC ;;
    esac

    echo -e "${COLOR}${message}${NC}"
}

# -------- Backup SSH Config --------
print_color yellow "Backing up /etc/ssh/sshd_config to /etc/ssh/sshd_config.bak"
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# -------- Harden SSH Config --------
print_color yellow "Hardening SSH configuration..."

# Change default port from 22 to 2222
sudo sed -i 's/^#\?Port .*/Port 2222/' /etc/ssh/sshd_config

# Disable root login
sudo sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config

# Disable password-based authentication
sudo sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config

# Disable keyboard-interactive auth
sudo sed -i 's/^#\?KbdInteractiveAuthentication .*/KbdInteractiveAuthentication no/' /etc/ssh/sshd_config

print_color green "SSH configuration hardened successfully."

# -------- Reload SSH Service --------
print_color yellow "Reloading sshd service..."
sudo systemctl reload ssh

if [ $? -eq 0 ]; then
    print_color green "sshd reloaded successfully. SSH changes are now active."
else
    print_color red "Failed to reload sshd. Please check sshd_config for syntax errors."
fi

