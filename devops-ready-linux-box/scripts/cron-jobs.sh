#!/bin/bash

# Utility function for colored output
print_color() {
  echo -e "\e[1;32m$1\e[0m"
}

print_color "Setting up cron jobs..."

# Ensure rsync is installed
sudo apt install -y rsync

# 1. Create script for daily disk usage
cat << 'EOF' | sudo tee /usr/local/bin/disk-usage-report.sh > /dev/null
#!/bin/bash
du -sh /home/* > /var/log/disk-usage.log
EOF
sudo chmod +x /usr/local/bin/disk-usage-report.sh

# 2. Create script for backup
cat << 'EOF' | sudo tee /usr/local/bin/backup-home.sh > /dev/null
#!/bin/bash
rsync -av --delete /home/ /backup/home-backup/ >> /var/log/rsync-backup.log 2>&1
EOF
sudo chmod +x /usr/local/bin/backup-home.sh

# 3. Create backup directory
sudo mkdir -p /backup/home-backup
sudo chown $(whoami):$(whoami) /backup/home-backup

# 4. Add cron jobs
(crontab -l 2>/dev/null; echo "0 2 * * * /usr/local/bin/disk-usage-report.sh") | crontab -
(crontab -l 2>/dev/null; echo "0 3 * * * /usr/local/bin/backup-home.sh") | crontab -

print_color "Cron jobs added: Daily disk usage at 2AM, home backup at 3AM."

