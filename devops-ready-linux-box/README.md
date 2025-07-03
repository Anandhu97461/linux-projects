# 🛡️ DevOps-Ready Linux Box

A practical Linux automation project that prepares a hardened, production-ready Ubuntu server with key DevOps practices like system logging, backups, and scheduled tasks — all through modular Bash scripting.

---

## 📦 Project Overview

This project focuses on daily operations that are vital for a real-world DevOps-ready system:

- 🔐 Secure system defaults
- 🕒 Scheduled backups with `cron`
- 📊 Disk usage logging
- ♻️ Log rotation with `logrotate`
- 🧼 System hygiene tasks
- 💾 Persistent mounts via `/etc/fstab`

It builds on foundational Linux skills and introduces light system automation — an essential step before configuration management tools like Ansible.

---

## 🛠️ Technologies Used

- **Ubuntu Server 22.04+**
- **Bash scripting**
- `cron`, `rsync`, `logrotate`
- `/etc/fstab` for persistent mounts
- File permissions & systemd integration

---

## 🚀 How to Use

> 📝 These scripts are modular. You can run them individually or automate with CI/CD later.

### 1️⃣ Make scripts executable

```bash
chmod +x scripts/*.sh
```
### 2️⃣ Run the cron setup script
```bash
sudo ./scripts/cron-jobs.sh
```
What it does:

Sets up a daily rsync job to back up /home to /backup/home-backup

Logs disk usage to /var/log/disk-usage.log every 12 hours

### 3️⃣ Configure logrotate
```bash
sudo ./scripts/logrotate.sh
```
What it does:

Adds a rule to rotate /var/log/disk-usage.log weekly

Keeps 4 backups

Uses gzip compression

### 📎 Notes
Backup folder defaults to /backup/home-backup

You can customize logrotate frequency inside /etc/logrotate.d/disk-usage-log

Ensure cron, rsync, and logrotate are installed on your system

All commands used are listed in commands-used.md

### 📚 Documentation
planning.md: Thought process, structure decisions, future improvements

commands-used.md: One-off commands used during setup or testing

### 🧠 Why This Project?
System automation and hygiene are often overlooked in early Linux learning. This project helps:

Practice real DevOps operations (backups, logging, rotation)

Prepare you for cron-based tasks before diving into Ansible or Jenkins

Improve your command over Bash scripting and permissions