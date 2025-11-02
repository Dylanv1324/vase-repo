# EduShare Setup Guide

Complete step-by-step instructions for deploying EduShare in your school.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Server Setup](#server-setup)
3. [Network Configuration](#network-configuration)
4. [Installing EduShare](#installing-edushare)
5. [Creating Student Accounts](#creating-student-accounts)
6. [Thin Client Setup](#thin-client-setup)
7. [Testing the System](#testing-the-system)
8. [Maintenance](#maintenance)

---

## Prerequisites

### Hardware Needed

**Server (choose one):**
- Raspberry Pi 4 (4GB RAM) - Recommended
- Raspberry Pi 3B+ (1GB RAM) - Minimum
- Old desktop/laptop (2GB+ RAM)
- Any Linux-compatible low-cost device

**Thin Clients (per student):**
- Raspberry Pi Zero W
- Old computers
- Any device with SSH capability

**Networking:**
- Router or switch
- Ethernet cables (recommended) or WiFi
- Power supply for all devices

### Software Requirements

**Server:**
- Linux OS (Ubuntu, Raspberry Pi OS, Debian recommended)
- SSH server
- Basic Linux utilities (included in most distributions)

**Thin Clients:**
- Terminal emulator (built-in on Linux/Mac)
- SSH client (Windows: PuTTY or built-in SSH)

---

## Server Setup

### Step 1: Prepare the Server Hardware

1. **Install Operating System**
   - For Raspberry Pi: Download and flash Raspberry Pi OS Lite
   - For PC: Install Ubuntu Server or lightweight Linux distro

2. **Initial Boot**
   ```bash
   # Update system
   sudo apt update
   sudo apt upgrade -y
   ```

3. **Set Static IP (Recommended)**

   Edit network configuration:
   ```bash
   sudo nano /etc/dhcpcd.conf
   ```

   Add at the end:
   ```
   interface eth0
   static ip_address=192.168.1.100/24
   static routers=192.168.1.1
   static domain_name_servers=192.168.1.1 8.8.8.8
   ```

   Restart networking:
   ```bash
   sudo systemctl restart dhcpcd
   ```

### Step 2: Run Server Configuration

1. **Navigate to installation directory**
   ```bash
   cd /path/to/learning-system
   ```

2. **Run server setup script**
   ```bash
   sudo ./server-setup.sh
   ```

   This script will:
   - Install/configure SSH server
   - Optimize for thin client access
   - Create student accounts (if requested)
   - Configure resource limits
   - Set up firewall rules
   - Apply system optimizations

3. **Follow the prompts**
   - Create student accounts? (y/n)
   - How many students? (e.g., 20)
   - Create swap file? (y for systems with <4GB RAM)

---

## Network Configuration

### Option 1: Local Network (Recommended for Classroom)

```
[Internet] ──► [Router] ──┬──► [Server: 192.168.1.100]
                          │
                          ├──► [Thin Client 1]
                          ├──► [Thin Client 2]
                          └──► [Thin Client N]
```

**Setup:**
1. Connect server to router via Ethernet
2. Connect thin clients to same network
3. Students connect to server's local IP

**Advantages:**
- Fast, low latency
- No internet required
- Secure (isolated from internet)

### Option 2: Internet Access (For Remote Learning)

**Additional steps:**
1. Configure router port forwarding (Port 22 → Server)
2. Use dynamic DNS service (if no static IP)
3. Strengthen security (SSH keys, fail2ban)

**Security considerations:**
```bash
# Install fail2ban (blocks brute force attacks)
sudo apt install fail2ban

# Configure SSH key authentication
sudo nano /etc/ssh/sshd_config
# Set: PasswordAuthentication no
# Set: PubkeyAuthentication yes
```

---

## Installing EduShare

### Step 1: Run Installation

```bash
cd /path/to/learning-system
sudo ./install.sh
```

The installer will:
- Create `/opt/edushare` directory
- Copy learning materials
- Install main script
- Create system-wide `learn` command
- Set up welcome message

### Step 2: Verify Installation

```bash
# Check installation
ls -la /opt/edushare

# Test the command
learn
```

You should see the EduShare interface!

### Step 3: Customize Welcome Message (Optional)

```bash
sudo nano /etc/motd
```

Edit to add school-specific information.

---

## Creating Student Accounts

### Automatic Creation (Recommended)

Done during `server-setup.sh`, but you can create more:

```bash
# Create students 51-60
for i in {51..60}; do
    username="student$(printf "%03d" "$i")"
    sudo useradd -m -s /bin/bash "$username"
    echo "$username:student" | sudo chpasswd
    sudo mkdir -p "/home/$username/my-learning-materials"
    sudo chown "$username:$username" "/home/$username/my-learning-materials"
    echo "Created: $username"
done
```

### Manual Creation

```bash
# Create individual account
sudo useradd -m -s /bin/bash student042
sudo passwd student042  # Set password

# Create materials directory
sudo mkdir -p /home/student042/my-learning-materials
sudo chown student042:student042 /home/student042/my-learning-materials
```

### Password Management

**Important: Change default passwords!**

```bash
# Change individual password
sudo passwd student001

# Or have students change their own
passwd  # Students run this after first login
```

### Bulk Password Reset Script

Create `reset-passwords.sh`:
```bash
#!/bin/bash
for i in {1..50}; do
    username="student$(printf "%03d" "$i")"
    password="NewPass$(shuf -i 1000-9999 -n 1)"  # Random password
    echo "$username:$password" | sudo chpasswd
    echo "$username: $password" >> passwords.txt
done
echo "Passwords saved to passwords.txt - Keep this secure!"
```

---

## Thin Client Setup

### Raspberry Pi Thin Clients

1. **Install Raspberry Pi OS Lite**

2. **Configure auto-login and auto-connect (Optional)**

   Edit `/etc/rc.local`:
   ```bash
   #!/bin/bash
   # Auto-connect to EduShare server
   ssh student001@192.168.1.100
   exit 0
   ```

3. **Simplify for young students**

   Create desktop shortcut or boot directly to SSH session

### Old PC Thin Clients

1. **Install lightweight Linux** (Lubuntu, Xubuntu, or Puppy Linux)

2. **Create desktop shortcut**

   `edushare.desktop`:
   ```
   [Desktop Entry]
   Name=EduShare Learning
   Exec=ssh student001@192.168.1.100
   Terminal=true
   Type=Application
   Icon=education
   ```

### Windows Thin Clients

1. **Install PuTTY** or use built-in SSH (Windows 10+)

2. **Create batch file** `connect-edushare.bat`:
   ```batch
   @echo off
   ssh student001@192.168.1.100
   pause
   ```

3. **Create desktop shortcut** to the batch file

---

## Testing the System

### Test 1: Server Connectivity

From server:
```bash
# Check SSH is running
sudo systemctl status sshd

# Check listening ports
sudo netstat -tlnp | grep :22

# Check server IP
ip addr show
```

### Test 2: Student Login

From thin client (or another computer):
```bash
# Test SSH connection
ssh student001@192.168.1.100

# You should see the welcome message
```

### Test 3: EduShare Interface

Once logged in:
```bash
# Run EduShare
learn

# Test navigation:
# - Select subject (e.g., press 1 for Mathematics)
# - Select lesson (e.g., press 1)
# - Download materials (press S)
# - Return to menu (press B)
```

### Test 4: Offline Access

```bash
# Download materials
# (Use option D in main menu)

# Check downloaded files
ls ~/my-learning-materials/

# Read a lesson offline
cat ~/my-learning-materials/mathematics/lessons/01_basic_arithmetic.txt
```

### Test 5: Multiple Concurrent Users

```bash
# From server, check active sessions
who

# Monitor system resources
htop

# Verify multiple students can connect simultaneously
```

---

## Maintenance

### Daily Tasks

```bash
# Check active users
who

# Check system resources
htop  # or: top
```

### Weekly Tasks

```bash
# Review system logs
sudo journalctl -u sshd -n 100

# Check disk space
df -h

# Update materials (as needed)
./add-content.sh list
```

### Monthly Tasks

```bash
# Backup materials
sudo tar -czf edushare-backup-$(date +%Y%m%d).tar.gz /opt/edushare/materials

# System updates
sudo apt update && sudo apt upgrade

# Review user accounts
cut -d: -f1 /etc/passwd | grep student
```

### Adding New Content

```bash
# Navigate to system directory
cd /path/to/learning-system

# Add a new subject
./add-content.sh add-subject geography

# Add lessons
./add-content.sh add-lesson geography my-lesson.txt

# Verify
./add-content.sh list
```

---

## Backup and Recovery

### Backup Script

Create `/root/backup-edushare.sh`:
```bash
#!/bin/bash
BACKUP_DIR="/root/edushare-backups"
DATE=$(date +%Y%m%d-%H%M%S)

mkdir -p "$BACKUP_DIR"

# Backup materials
tar -czf "$BACKUP_DIR/materials-$DATE.tar.gz" /opt/edushare/materials

# Backup user home directories (downloaded materials)
tar -czf "$BACKUP_DIR/student-data-$DATE.tar.gz" /home/student*/my-learning-materials

# Keep only last 7 backups
ls -t "$BACKUP_DIR" | tail -n +8 | xargs -I {} rm "$BACKUP_DIR/{}"

echo "Backup completed: $DATE"
```

### Automated Backups

```bash
# Make script executable
sudo chmod +x /root/backup-edushare.sh

# Add to crontab (daily at 2 AM)
sudo crontab -e

# Add line:
0 2 * * * /root/backup-edushare.sh
```

### Recovery

```bash
# Restore materials
sudo tar -xzf materials-YYYYMMDD-HHMMSS.tar.gz -C /

# Restore student data
sudo tar -xzf student-data-YYYYMMDD-HHMMSS.tar.gz -C /
```

---

## Scaling Up

### Supporting More Students

1. **Increase resource limits**
   ```bash
   sudo nano /etc/security/limits.conf

   # Increase values:
   @students        soft    nproc          100
   @students        hard    nproc          200
   ```

2. **Increase SSH connection limits**
   ```bash
   sudo nano /etc/ssh/sshd_config

   MaxSessions 100
   MaxStartups 100:30:200

   sudo systemctl restart sshd
   ```

3. **Monitor and upgrade hardware if needed**

### Multiple Servers (Advanced)

For very large schools:
- Deploy multiple servers
- Assign students to different servers
- Load balance by subject or class

---

## Common Configuration Scenarios

### Scenario 1: Small Rural School (10-20 students)

**Hardware:**
- 1x Raspberry Pi 4 (4GB)
- 10-20x Raspberry Pi Zero W thin clients

**Configuration:**
- Local network only
- All devices on same switch
- Simple password authentication

### Scenario 2: Medium School (50-100 students)

**Hardware:**
- 1x Low-cost desktop PC (8GB RAM)
- Mixture of thin clients

**Configuration:**
- Local network
- Multiple sessions scheduled throughout day
- SSH key authentication
- Regular backups

### Scenario 3: Multiple Classrooms

**Hardware:**
- 1x Server per building/classroom cluster
- Networked together

**Configuration:**
- Central content repository (shared via NFS/Samba)
- Multiple independent servers
- Centralized user management (optional: LDAP)

---

## Optimization Tips

### For Low-Memory Servers (<2GB RAM)

```bash
# Reduce SSH session limits
# Edit /etc/ssh/sshd_config:
MaxSessions 20

# Enable ZRAM (compressed RAM)
sudo apt install zram-config
```

### For Slow Network Connections

```bash
# Enable SSH compression
# Edit /etc/ssh/sshd_config:
Compression yes

# Use delayed compression
Compression delayed
```

### For Many Concurrent Users

```bash
# Increase kernel limits
sudo nano /etc/sysctl.conf

# Add:
net.core.somaxconn = 1024
net.ipv4.tcp_max_syn_backlog = 2048

# Apply:
sudo sysctl -p
```

---

## Next Steps

After setup is complete:

1. Test with small group of students
2. Train teachers on system usage
3. Create more subject content
4. Establish backup routine
5. Monitor and optimize
6. Scale as needed

---

**Your EduShare system is now ready to transform learning in your school!**
