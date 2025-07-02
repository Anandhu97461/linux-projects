# 💽 Storage and Performance Lab

This project simulates a real-world Linux environment focused on storage configuration, performance monitoring, and fine-grained permission management. It includes partitioning, LVM setup, ACL configuration, resource limits, and monitoring tool installation — all automated using shell scripts.

---

## 📦 Project Structure

server-storage-lab/
├── README.md
├── scripts/
│ ├── partition-setup.sh
│ ├── lvm-setup.sh
│ ├── resource-limits.sh
│ ├── acl-setup.sh
│ └── performance-tools.sh
└── notes/
├── planning.md
└── commands-used.md

---

## 🚀 What This Project Covers

| Section | Topic | Highlights |
|--------|-------|------------|
| 1️⃣ | **Disk Partitioning** | fdisk, mkfs, ext4 & xfs formatting, persistent fstab mount |
| 2️⃣ | **LVM Setup** | pvcreate, vgcreate, lvcreate, ext4, mount & persistence |
| 3️⃣ | **Resource Limits** | ulimit settings via `/etc/security/limits.conf` |
| 4️⃣ | **ACL Configuration** | `setfacl`, `getfacl`, ACL-based access control on files |
| 5️⃣ | **Performance Monitoring** | iostat, pidstat, stress, ncdu, du, htop, iotop |

---

## 🧰 Technologies Used

- Ubuntu Server (22.04 / 24.04)
- Bash Shell Scripting
- fdisk, mkfs, mount, fstab
- LVM: pvcreate, vgcreate, lvcreate
- Filesystem ACLs
- Resource Limits: `limits.conf`, `ulimit`
- Monitoring Tools: sysstat, stress, iotop, ncdu, htop

---

## 📁 Prerequisites

- A VM with **3 disks**:
  - `/dev/sda`: root OS disk
  - `/dev/sdb`: for partitioning and ACLs
  - `/dev/sdc`: for LVM and performance testing
- Sudo access and `apt` package manager
- Internet connectivity (for installing tools)

---

## 🛠️ How to Run Scripts

Run each script **in order** from the `scripts/` folder:

```bash
chmod +x scripts/*.sh

# Step 1: Partition, Format and Mount
sudo ./scripts/partition-setup.sh

# Step 2: LVM Volume Creation and Mounting
sudo ./scripts/lvm-setup.sh

# Step 3: Resource Limits (e.g., nproc, open files)
sudo ./scripts/resource-limits.sh

# Step 4: Configure ACL on ext4 partition
sudo ./scripts/acl-setup.sh

# Step 5: Install and Test Monitoring Tools
sudo ./scripts/performance-tools.sh