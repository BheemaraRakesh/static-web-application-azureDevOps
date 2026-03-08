# Linux Concepts

## Overview
Linux is an open-source Unix-like operating system kernel that serves as the foundation for various Linux distributions. It's widely used in servers, embedded systems, and cloud infrastructure due to its stability, security, and flexibility.

## Key Concepts

### 1. Kernel
The core component that manages hardware resources and provides low-level services.

**Example:**
```bash
# Check kernel version
uname -r
# Output: 5.4.0-74-generic
```

### 2. Distributions
Different flavors of Linux with their own package managers and tools.

**Popular Distributions:**
- Ubuntu/Debian (apt)
- CentOS/RHEL (yum/dnf)
- SUSE (zypper)

### 3. File System Hierarchy
Standard directory structure defined by FHS (Filesystem Hierarchy Standard).

**Key Directories:**
- `/` - Root directory
- `/home` - User home directories
- `/etc` - Configuration files
- `/var` - Variable data (logs, databases)
- `/usr` - User programs
- `/tmp` - Temporary files

### 4. Permissions
Access control system using user/group/other permissions.

**Permission Types:**
- r (read) - 4
- w (write) - 2
- x (execute) - 1

**Example:**
```bash
# Change permissions
chmod 755 script.sh  # rwxr-xr-x

# Change ownership
chown user:group file.txt
```

### 5. Processes
Running programs managed by the kernel.

**Process Management:**
```bash
# List processes
ps aux

# Kill process
kill 1234

# Background process
command &
```

### 6. Package Management
Installing and managing software packages.

**Examples:**
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install nginx

# CentOS/RHEL
sudo yum install nginx
```

### 7. Systemd
Modern init system for managing services.

**Service Management:**
```bash
# Start service
sudo systemctl start nginx

# Enable at boot
sudo systemctl enable nginx

# Check status
sudo systemctl status nginx
```

## Real Project Use Cases

### Web Server Setup
```bash
# Install Apache
sudo apt update
sudo apt install apache2

# Start service
sudo systemctl start apache2
sudo systemctl enable apache2

# Configure firewall
sudo ufw allow 80
```

### User Management
```bash
# Create user
sudo useradd -m -s /bin/bash john

# Set password
sudo passwd john

# Add to sudo group
sudo usermod -aG sudo john
```

### Log Management
```bash
# View system logs
journalctl

# Monitor logs in real-time
tail -f /var/log/syslog

# Search logs
grep "error" /var/log/apache2/error.log
```

## Best Practices
- Regularly update the system
- Use strong passwords and SSH keys
- Implement proper backups
- Monitor system resources
- Use automation for repetitive tasks
- Follow security hardening guidelines