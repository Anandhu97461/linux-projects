#!/bin/bash

TARGET_FILE="/mnt/data1/project.txt"
USERNAME="devopsadmin"

print_color() {
  NC='\033[0m'
  case $1 in
    "green") COLOR='\033[0;32m' ;;
    "red") COLOR='\033[0;31m' ;;
    *) COLOR='\033[0m' ;;
  esac
  echo -e "${COLOR}$2${NC}"
}

# Check if target file exists
if [ ! -f "$TARGET_FILE" ]; then
  sudo touch "$TARGET_FILE"
  sudo chown "$USERNAME":"$USERNAME" "$TARGET_FILE"
  print_color green "Created file: $TARGET_FILE"
fi

# Apply ACL
sudo setfacl -m u:$USERNAME:rw "$TARGET_FILE"
print_color green "Set ACL: $USERNAME has rw permissions on $TARGET_FILE"

# Show ACL
print_color green "Current ACL on $TARGET_FILE:"
getfacl "$TARGET_FILE"

