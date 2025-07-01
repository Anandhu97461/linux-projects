## 🔑 SSH Key-Based Authentication (Client Side)

These are the commands used from the **client/local machine** to set up secure access to the remote server.

---

### 1. Generate SSH Key Pair

```bash
ssh-keygen
```
Generates a new RSA key pair (stored by default in ~/.ssh/id_rsa and ~/.ssh/id_rsa.pub).

### 2. Copy Public Key to Server (on custom SSH port)
```bash
ssh-copy-id -p 2222 devopsadmin@192.168.108.133
```
Adds the local public key to the remote server's ~/.ssh/authorized_keys to enable passwordless login.


### 3. View Hostname Mapping
```bash
cat /etc/hosts
```
Used to verify or add an entry like:

```
192.168.108.133 myserver
```
This allows using ssh -p 2222 devopsadmin@myserver instead of typing the IP each time.