#!/bin/bash

USERNAME="devopsadmin"
LIMITS_FILE="/etc/security/limits.conf"

print_color() {
  NC='\033[0m'  # No Color
  case $1 in
    "green") COLOR='\033[0;32m' ;;
    "red") COLOR='\033[0;31m' ;;
    *) COLOR='\033[0m' ;;
  esac
  echo -e "${COLOR}$2${NC}"
}

print_color green "Configuring resource limits for user: $USERNAME"

# Check if entry already exists
if grep -q "^$USERNAME" $LIMITS_FILE; then
  print_color red "Resource limits already configured for $USERNAME in $LIMITS_FILE"
else
  echo "$USERNAME   soft   nproc    100" | sudo tee -a $LIMITS_FILE
  echo "$USERNAME   hard   nproc    150" | sudo tee -a $LIMITS_FILE
  echo "$USERNAME   soft   nofile   1024" | sudo tee -a $LIMITS_FILE
  echo "$USERNAME   hard   nofile   2048" | sudo tee -a $LIMITS_FILE
  echo "$USERNAME   soft   cpu      10" | sudo tee -a $LIMITS_FILE
  echo "$USERNAME   hard   cpu      20" | sudo tee -a $LIMITS_FILE
  print_color green "Limits added successfully to $LIMITS_FILE"
fi

print_color green "These limits will apply at next login. Log out and back in to test them."


