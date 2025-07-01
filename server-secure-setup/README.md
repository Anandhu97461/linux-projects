# 🚀 Secure Linux Server Setup with LVM, Networking, and Monitoring

## 🧩 Overview
This project automates the setup of a secure and well-monitored Ubuntu Server using Bash scripting.

## 🛠️ Technologies Used
- Ubuntu Server 22.04+
- Bash scripting
- LVM
- UFW Firewall
- OpenSSH
- Netplan
- sysstat, htop, ncdu

## 🧾 Prerequisites
- Ubuntu VM or Cloud instance
- A secondary disk attached (for LVM)

## 🧰 Scripts
Each script is modular and located under the `scripts/` directory:

| Script                 | Purpose                                 |
|------------------------|-----------------------------------------|
| `user-setup.sh`        | Adds `devopsadmin`, grants sudo access, locks root |
| `ssh-hardening.sh`     | Configures SSH for key-only login and custom port |
| `firewall-setup.sh`    | Enables UFW and applies basic rules     |
| `swap-lvm-setup.sh`    | Sets up LVM for `/data` and swap        |
| `monitoring-tools.sh`  | Installs tools and simulates performance |

## ▶️ How to Run
Run each script individually after verifying prerequisites:

```bash
chmod +x scripts/*.sh
sudo ./scripts/user-setup.sh
sudo ./scripts/ssh-hardening.sh
...
