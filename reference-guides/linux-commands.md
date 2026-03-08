# Linux Commands Reference

Essential Linux commands for system administration, file management, and production server operations.

## File and Directory Operations
```bash
# List files
ls -la

# Change directory
cd /path/to/directory

# Create directory
mkdir -p /path/to/new/directory

# Copy files
cp source.txt destination.txt
cp -r source_dir destination_dir

# Move/rename files
mv old_name new_name

# Remove files
rm file.txt
rm -rf directory/

# Find files
find /path -name "*.txt"

# Search in files
grep "pattern" file.txt
grep -r "pattern" /path/to/search
```

## System Information
```bash
# System info
uname -a

# CPU info
cat /proc/cpuinfo
lscpu

# Memory info
free -h
cat /proc/meminfo

# Disk usage
df -h
du -sh /path/to/directory

# Network interfaces
ip addr show
ifconfig

# Routing table
ip route show

# Open ports
netstat -tlnp
ss -tlnp

# System load
uptime
top
htop
```

## Process Management
```bash
# List processes
ps aux

# Kill process
kill <pid>
kill -9 <pid>

# Kill by name
pkill process_name

# Background process
command &
nohup command &

# View background jobs
jobs

# Bring job to foreground
fg %1

# Send job to background
bg %1
```

## User Management
```bash
# Current user
whoami
id

# Switch user
su - username
sudo command

# Add user
useradd username
adduser username

# Set password
passwd username

# Delete user
userdel username

# Groups
groups username
usermod -aG groupname username
```

## Package Management (Ubuntu/Debian)
```bash
# Update package list
sudo apt update

# Upgrade packages
sudo apt upgrade

# Install package
sudo apt install package_name

# Remove package
sudo apt remove package_name

# Search packages
apt search package_name

# List installed packages
apt list --installed
```

## Package Management (CentOS/RHEL)
```bash
# Update packages
sudo yum update
sudo dnf update

# Install package
sudo yum install package_name
sudo dnf install package_name

# Remove package
sudo yum remove package_name

# Search packages
yum search package_name
dnf search package_name
```

## File Permissions
```bash
# Change permissions
chmod 755 file.sh
chmod u+x file.sh

# Change ownership
chown user:group file.txt

# Change group
chgrp group file.txt

# Setuid/setgid
chmod u+s executable
chmod g+s directory
```

## Text Processing
```bash
# View file
cat file.txt
less file.txt
head -n 10 file.txt
tail -n 10 file.txt
tail -f log.txt

# Edit file
nano file.txt
vim file.txt

# Sort lines
sort file.txt

# Unique lines
uniq file.txt

# Count lines/words
wc -l file.txt

# Cut columns
cut -d',' -f1 file.csv

# Replace text
sed 's/old/new/g' file.txt
```

## Networking
```bash
# Ping host
ping google.com

# DNS lookup
nslookup google.com
dig google.com

# Download file
wget https://example.com/file.txt
curl -O https://example.com/file.txt

# SSH connection
ssh user@hostname
ssh -i key.pem user@hostname

# SCP file transfer
scp file.txt user@hostname:/path/
scp -r directory/ user@hostname:/path/

# Rsync
rsync -av source/ destination/
```

## Compression
```bash
# Create tar archive
tar -czf archive.tar.gz directory/

# Extract tar archive
tar -xzf archive.tar.gz

# Create zip
zip -r archive.zip directory/

# Extract zip
unzip archive.zip

# Compress with gzip
gzip file.txt
gunzip file.txt.gz
```

## System Monitoring
```bash
# System logs
journalctl
journalctl -u service_name
tail -f /var/log/syslog

# Disk I/O
iostat -x 1

# Network stats
sar -n DEV 1

# Process monitoring
ps aux | grep process_name

# Memory usage
vmstat 1

# Check service status
systemctl status service_name
service service_name status
```

## Firewall (UFW)
```bash
# Enable firewall
sudo ufw enable

# Allow port
sudo ufw allow 80
sudo ufw allow 22/tcp

# Deny port
sudo ufw deny 80

# List rules
sudo ufw status

# Delete rule
sudo ufw delete allow 80
```

## Cron Jobs
```bash
# Edit crontab
crontab -e

# List crontab
crontab -l

# Example cron entries
# Every day at 2 AM
0 2 * * * /path/to/script.sh

# Every Monday at 9 AM
0 9 * * 1 /path/to/script.sh

# Every 5 minutes
*/5 * * * * /path/to/script.sh
```

## Environment Variables
```bash
# Set variable
export MY_VAR=value

# Show variable
echo $MY_VAR

# Show all variables
env

# Add to PATH
export PATH=$PATH:/new/path

# Persistent variables (in ~/.bashrc)
echo 'export MY_VAR=value' >> ~/.bashrc
source ~/.bashrc
```

## Best Practices
- Use absolute paths in scripts
- Implement proper error handling
- Use sudo only when necessary
- Regularly update the system
- Monitor system resources
- Implement log rotation
- Use strong passwords and SSH keys
- Backup important data
- Use version control for configuration files
- Document custom scripts and configurations