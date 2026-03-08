# Shell Scripting Concepts

## Overview
Shell scripting involves writing scripts using shell commands to automate tasks, manage systems, and perform complex operations. Bash (Bourne Again SHell) is the most common shell for scripting.

## Key Concepts

### 1. Shebang
First line that specifies the interpreter.

**Example:**
```bash
#!/bin/bash
# This is a bash script
```

### 2. Variables
Store and manipulate data.

**Examples:**
```bash
# Variable assignment
name="John"
age=25

# Using variables
echo "Hello $name"
echo "Age: ${age} years"

# Environment variables
echo $HOME
echo $PATH
```

### 3. Command Substitution
Execute commands and capture output.

**Examples:**
```bash
# Old syntax
current_dir=`pwd`

# New syntax (preferred)
current_dir=$(pwd)

# Use in script
echo "Current directory: $current_dir"
```

### 4. Conditional Statements
Make decisions based on conditions.

**Examples:**
```bash
# if statement
if [ $age -gt 18 ]; then
    echo "Adult"
else
    echo "Minor"
fi

# case statement
case $choice in
    1) echo "Option 1" ;;
    2) echo "Option 2" ;;
    *) echo "Invalid option" ;;
esac
```

### 5. Loops
Repeat operations.

**Examples:**
```bash
# for loop
for file in *.txt; do
    echo "Processing $file"
done

# while loop
counter=1
while [ $counter -le 5 ]; do
    echo "Count: $counter"
    ((counter++))
done
```

### 6. Functions
Reusable code blocks.

**Example:**
```bash
# Function definition
greet() {
    echo "Hello $1"
}

# Function call
greet "World"
```

### 7. Input/Output Redirection
Control input and output streams.

**Examples:**
```bash
# Redirect output to file
echo "Hello" > output.txt

# Append to file
echo "World" >> output.txt

# Redirect input
sort < input.txt

# Pipe output
ls -l | grep ".txt"
```

### 8. Error Handling
Handle errors and unexpected situations.

**Examples:**
```bash
# Exit on error
set -e

# Custom error handling
command || { echo "Command failed"; exit 1; }

# Trap signals
trap 'echo "Script interrupted"' INT
```

## Real Project Examples

### System Backup Script
```bash
#!/bin/bash

# Backup script
BACKUP_DIR="/backup"
SOURCE_DIR="/home/user/data"
DATE=$(date +%Y%m%d_%H%M%S)

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Create tar archive
tar -czf $BACKUP_DIR/backup_$DATE.tar.gz $SOURCE_DIR

# Remove old backups (older than 7 days)
find $BACKUP_DIR -name "backup_*.tar.gz" -mtime +7 -delete

echo "Backup completed: backup_$DATE.tar.gz"
```

### Deployment Script
```bash
#!/bin/bash

# Deployment script
APP_NAME="myapp"
APP_DIR="/opt/$APP_NAME"
BACKUP_DIR="/opt/backups"

# Function to log messages
log() {
    echo "$(date): $1"
}

# Stop service
log "Stopping $APP_NAME service"
sudo systemctl stop $APP_NAME || log "Service was not running"

# Backup current version
if [ -d "$APP_DIR" ]; then
    log "Creating backup"
    sudo cp -r $APP_DIR $BACKUP_DIR/${APP_NAME}_$(date +%Y%m%d_%H%M%S)
fi

# Deploy new version
log "Deploying new version"
sudo cp -r ./build/* $APP_DIR/

# Start service
log "Starting $APP_NAME service"
sudo systemctl start $APP_NAME

# Check if service is running
if sudo systemctl is-active --quiet $APP_NAME; then
    log "Deployment successful"
else
    log "Deployment failed"
    exit 1
fi
```

### Monitoring Script
```bash
#!/bin/bash

# System monitoring script
THRESHOLD=80
EMAIL="admin@example.com"

# Check disk usage
disk_usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

if [ $disk_usage -gt $THRESHOLD ]; then
    echo "Disk usage is at ${disk_usage}%" | mail -s "Disk Space Alert" $EMAIL
fi

# Check memory usage
mem_usage=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100.0}')

if [ $mem_usage -gt $THRESHOLD ]; then
    echo "Memory usage is at ${mem_usage}%" | mail -s "Memory Usage Alert" $EMAIL
fi

# Check CPU usage
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')

if [ $cpu_usage -gt $THRESHOLD ]; then
    echo "CPU usage is at ${cpu_usage}%" | mail -s "CPU Usage Alert" $EMAIL
fi
```

## Best Practices
- Use descriptive variable names
- Add comments for complex logic
- Use functions for reusable code
- Implement proper error handling
- Test scripts in safe environments
- Use version control for scripts
- Follow naming conventions
- Avoid hardcoding values (use variables/config files)