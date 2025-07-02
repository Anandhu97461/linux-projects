# 📄 Commands Used — Storage and Performance Lab

This file lists all the useful one-liner commands run manually during project development to test or validate disk, LVM, ACL, resource limits, and monitoring setup.

---

## 🔧 Partition and Filesystem Checks

```bash
lsblk
sudo fdisk -l
sudo partprobe
sudo mkfs.ext4 /dev/sdb1
sudo mkfs.xfs /dev/sdb2
sudo mount | grep sdb
cat /etc/fstab
```

## 💽 LVM Verification
```bash
sudo pvdisplay
sudo vgdisplay
sudo lvdisplay
lsblk | grep vgperf
mount | grep lvdata
```

## 📉 Resource Limits Testing
```bash
ulimit -a
ulimit -n       # Check open file limit
ulimit -u       # Check process limit
ulimit -c       # Check core file size limit
```

## 🛂 ACL Management
```bash
sudo tune2fs -l /dev/sdb1 | grep "Default mount"
mount | grep acl
sudo setfacl -m u:devopsadmin:rw /mnt/data1/test.txt
getfacl /mnt/data1/test.txt
```

## 📊 Performance Monitoring
```bash
sudo apt install -y sysstat htop iotop ncdu stress
iostat -dx 2 5
pidstat -d 2 5
htop
ncdu /mnt/data1
du -sh /mnt/data1/*
df -h
```

## 🔥 Stress Testing
```bash
stress --cpu 2 --io 1 --vm 1 --vm-bytes 128M --timeout 30
```

## 📁 Mount and Systemd Reload (when needed)
```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
```

## 🧪 Miscellaneous Validation
```bash
id devopsadmin
groups devopsadmin
getent passwd devopsadmin
```

## 📝 Reminder

These were manually executed for testing, debugging, and validation outside the scripts. All repeatable automation has been bundled into the scripts/ directory.


---