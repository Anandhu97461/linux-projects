#!/bin/bash

# Utility function for colored output
print_color() {
  echo -e "\e[1;36m$1\e[0m"
}

print_color "Configuring log rotation..."

# Create logrotate config
sudo tee /etc/logrotate.d/custom-logs > /dev/null << EOF
/var/log/disk-usage.log
/var/log/rsync-backup.log {
    daily
    missingok
    rotate 7
    compress
    delaycompress
    notifempty
    create 640 root adm
}
EOF

print_color "Log rotation policy set for custom log files."

