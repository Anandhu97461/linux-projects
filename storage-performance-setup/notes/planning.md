## ⚙️ Design and Implementation Plan

### 1️⃣ Partition Setup (`partition-setup.sh`)

- Disk: `/dev/sdb`
- Create:
  - `/dev/sdb1` → ext4 → `/mnt/data1`
  - `/dev/sdb2` → xfs → `/mnt/data2`
- Tools used: `fdisk`, `mkfs.ext4`, `mkfs.xfs`, `mount`, `/etc/fstab`

### 2️⃣ LVM Setup (`lvm-setup.sh`)

- Disk: `/dev/sdc`
- Setup:
  - Create PV, VG (`vgperf`), and LV (`lvdata`)
  - Format LV as ext4, mount at `/mnt/lvdata`
  - Make mount persistent via `/etc/fstab`
- Tools: `pvcreate`, `vgcreate`, `lvcreate`, `mkfs.ext4`, `mount`

### 3️⃣ Resource Limits (`resource-limits.sh`)

- Configure soft and hard resource limits for users in `/etc/security/limits.conf`
- Example: restrict `nproc`, `nofile`, `cpu` for specific users
- Validate with `ulimit -a` as the target user
- Skills: PAM-based enforcement, soft/hard limits, shell testing

### 4️⃣ ACL Setup (`acl-setup.sh`)

- Enable ACL support on `/mnt/data1` during mounting
- Use `setfacl`, `getfacl` to assign user-specific file permissions
- Verify with test users and file access behavior

### 5️⃣ Performance Monitoring (`performance-tools.sh`)

- Install tools:
  - `sysstat` (iostat, pidstat)
  - `htop`, `ncdu`, `iotop`, `du`, `df`, `stress`
- Perform:
  - I/O monitoring: `iostat`, `pidstat`
  - Load visualization: `htop`, `iotop`
  - Disk usage: `du`, `df`, `ncdu`
  - Stress simulation: `stress` for CPU, memory, disk

---

## 📄 Documentation Plan

- **README.md**
  - Overview of each section
  - Script execution order
  - Technologies used
  - Optional: screenshots and diagrams

- **commands-used.md**
  - One-liner commands used during manual verification
  - Helpful system checks, `lsblk`, `mount`, etc.

---

## ✅ Outcomes

This project helps build confidence in:

- Partitioning, LVM management, and persistent storage
- Soft and hard user-level limits using PAM
- Using ACLs to go beyond Linux’s standard permissions
- Installing and using real-world monitoring tools
- Simulating and interpreting system load with stress testing
