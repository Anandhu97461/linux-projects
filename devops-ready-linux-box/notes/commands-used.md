## 🧾 Crontab & Scheduling

```bash
crontab -e                             # Edit current user's crontab
crontab -l                             # List current user's crontab
```

## 📁 Home Directory Backup with rsync
```bash
sudo mkdir -p /backup/home-backup/
sudo rsync -a --delete /home/ /backup/home-backup/
```
## 📊 Disk Usage Logging
```bash
df -h > /var/log/disk-usage.log
```
## 📑 Logrotate Configuration
```bash
sudo nano /etc/logrotate.d/disk-usage-log     # Created custom logrotate rule
sudo logrotate --debug /etc/logrotate.conf    # Test config (dry run)
sudo logrotate -f /etc/logrotate.conf         # Force log rotation (careful!)
```
## 🧾 File Permissions & Ownership
```bash
sudo chown root:adm /var/log/disk-usage.log
sudo chmod 640 /var/log/disk-usage.log
```
## 📦 Packages (already preinstalled on most systems)
```bash
sudo apt install rsync logrotate cron
```