## 🔍 Project Goal

This project simulates a production-ready Linux box setup with a focus on automation, hygiene, and system maintenance tasks that are essential for long-term reliability and observability.

It adds to my previous foundational projects by including scheduled tasks and log management — things every DevOps engineer should master.

---

## 🧠 Why This Project?

After working on user creation, SSH security, firewall configuration, LVM, and monitoring tools, I realized that regular maintenance tasks like backups and disk monitoring were still missing.

This project fills that gap by automating:

- Daily disk usage reporting
- Home directory backups
- Log rotation and cleanup

These are critical for building confidence in maintaining long-lived servers.

---

## 📁 Project Breakdown

| Section           | Description                                                                 |
|------------------|-----------------------------------------------------------------------------|
| `cron-jobs.sh`    | Adds scheduled tasks to crontab — disk usage logging and `/home` backup     |
| `logrotate.sh`    | Configures logrotate to manage custom logs created by the cron jobs         |

---

## 🔧 Key Features

- Disk usage log created daily: `/var/log/disk-usage.log`
- Daily `/home` backup to `/backup/home-backup/` using `rsync`
- Backup uses `--delete` to sync deletions as well
- Log rotation compresses logs daily, keeps 7 copies
- Permissions: `640` with owner `root`, group `adm`
- Cron entries created via `crontab -l | grep -q` check to prevent duplicates

---

## 💡 Things I Focused On

- Reusability: The script can be safely re-run
- Ownership and permissions for backup and logs
- Scheduling with crontab in a clean way
- Separation of tasks into script + logrotate config

---

## 🛠️ Future Enhancements (Optional)

- Add email alerts for high disk usage or backup failure
- Track CPU/RAM usage periodically via cron
- Encrypt the backup directory using GPG
- Use `systemd-timers` instead of cron (for learning systemd-based automation)
- Retain logs in S3 or external backup location

---

## ✅ Dependencies

- `rsync` (for backup)
- `cron` (default on most distros)
- `logrotate` (default on most distros)

---