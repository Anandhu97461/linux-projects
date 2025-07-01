# 🧩 Secure Linux Server Setup — Planning Notes

## 📌 Project Overview

This project is designed to simulate a secure Linux server setup following core LFCS concepts. It includes user and SSH configuration, firewall setup, LVM-based storage provisioning, monitoring tools, and a statically configured network interface.

The goal is to bring all foundational Linux administration topics together into a structured, repeatable project.

---

## 🛠️ Project Breakdown

### 1. 👤 User and Group Setup

- Created a new administrative user: `devopsadmin`
- Added the user to the `sudo` group
- Created a separate sudoers entry under `/etc/sudoers.d/devopsadmin` to allow passwordless sudo
- Locked the root account for enhanced security

**Why this structure?**  
Modular and explicit sudo privileges improve auditing and security.

---

### 2. 🔐 SSH Hardening

- Changed default SSH port from `22` to `2222`
- Disabled root login via SSH
- Disabled password and keyboard-interactive authentication
- Configured SSH key-based login (manually copied the key from local machine)

**Why?**  
Minimizing attack surface and enforcing key-only authentication are best practices for secure remote access.

---

### 3. 🔥 Firewall Configuration

- Allowed SSH traffic on port `2222` using `ufw`
- Set default policy to deny all incoming traffic
- Enabled `ufw` firewall and verified rules

**Why?**  
Only necessary traffic should be allowed, and defaults should be restrictive.

---

### 4. 💽 LVM and Swap Setup

- Attached a new disk (`/dev/sdb`) using VMware
- Created:
  - Physical Volume: `/dev/sdb`
  - Volume Group: `vgdata`
  - Logical Volumes:
    - `datalv` (5GB) for `/data`
    - `swaplv` (1GB) for swap
- Formatted `datalv` as `ext4` and mounted at `/data`
- Enabled and activated swap with `swapon`

**Why?**  
LVM provides flexibility for storage resizing and management. Separate data and swap improves clarity and control.

---

### 5. 🌐 Static IP and Hostname Setup

**Interface Used:** `ens33`  
**Static IP Assigned:** `192.168.108.133`  
**Gateway:** `192.168.108.2`  
**Netplan File Modified:** `/etc/netplan/50-cloud-init.yaml`

```yaml
network:
  version: 2
  ethernets:
    ens33:
      dhcp4: false
      addresses:
        - 192.168.108.133/24
      routes:
        - to: default
          via: 192.168.108.2
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1]
```
**Command Used:**

```bash
sudo netplan apply
```
**Local /etc/hosts Entry:**

```bash
192.168.108.133 myserver
```
**Why?**
Static IP ensures consistent connectivity. /etc/hosts enables hostname-based access for testing and scripting.

---

### 6. 📈 Monitoring and Diagnostics

**Installed tools:**

sysstat for iostat and pidstat

htop for process overview

ncdu, du, and df for disk usage inspection

**Performance Test:**

Used dd for disk write test


**Why?**
These tools give visibility into performance bottlenecks, process resource usage, and disk activity—essential for any server.

### 📎 Notes

Made sure to test SSH after each major change to avoid lockouts

Used print_color in all scripts for better CLI readability

All configurations are kept modular under scripts/ and are executable independently
