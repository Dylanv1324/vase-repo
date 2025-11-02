#!/bin/bash

# EduShare Server Configuration Script
# Configures a low-cost server for thin client SSH access

echo "╔════════════════════════════════════════════════════════════════════════════╗"
echo "║                  EduShare Server Configuration Helper                      ║"
echo "╚════════════════════════════════════════════════════════════════════════════╝"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)"
    exit 1
fi

echo "This script will help configure your server for thin client access."
echo ""

# Install SSH server if needed
echo "[Step 1] Checking SSH server..."
if ! command -v sshd &> /dev/null; then
    echo "SSH server not found. Installing..."
    apt-get update && apt-get install -y openssh-server
else
    echo "✓ SSH server is installed"
fi

# Configure SSH for better performance on thin clients
echo ""
echo "[Step 2] Configuring SSH for thin clients..."

SSHD_CONFIG="/etc/ssh/sshd_config"
SSHD_BACKUP="${SSHD_CONFIG}.backup-$(date +%Y%m%d-%H%M%S)"

# Backup existing config
cp "$SSHD_CONFIG" "$SSHD_BACKUP"
echo "  Backup created: $SSHD_BACKUP"

# Add/modify SSH settings for thin clients
cat >> "$SSHD_CONFIG" << 'EOF'

# EduShare Thin Client Optimizations
ClientAliveInterval 300
ClientAliveCountMax 3
MaxSessions 50
MaxStartups 50:30:100
Compression yes
EOF

echo "✓ SSH configured for thin client access"

# Create student user template
echo ""
echo "[Step 3] Student account setup..."
echo "Do you want to create student accounts now? (y/n)"
read -r create_users

if [[ "$create_users" =~ ^[Yy]$ ]]; then
    echo "How many student accounts? (e.g., 10, 20, 50)"
    read -r num_students

    echo "Creating $num_students student accounts..."

    for i in $(seq 1 "$num_students"); do
        username="student$(printf "%03d" "$i")"

        # Create user if doesn't exist
        if ! id "$username" &>/dev/null; then
            useradd -m -s /bin/bash "$username"

            # Set simple password (should be changed in production)
            echo "$username:student" | chpasswd

            # Create learning materials directory
            mkdir -p "/home/$username/my-learning-materials"
            chown "$username:$username" "/home/$username/my-learning-materials"

            echo "  Created: $username (password: student - CHANGE THIS!)"
        fi
    done

    echo ""
    echo "⚠ IMPORTANT: Change default passwords for security!"
    echo "   Use: passwd student001, passwd student002, etc."
fi

# Set up resource limits for thin clients
echo ""
echo "[Step 4] Configuring resource limits..."

cat >> /etc/security/limits.conf << 'EOF'

# EduShare - Limits for student accounts
@students        soft    nproc          50
@students        hard    nproc          100
@students        soft    nofile         1024
@students        hard    nofile         2048
EOF

# Create students group if it doesn't exist
groupadd -f students

echo "✓ Resource limits configured"

# Firewall configuration
echo ""
echo "[Step 5] Firewall configuration..."
if command -v ufw &> /dev/null; then
    echo "Configuring UFW firewall..."
    ufw allow ssh
    echo "✓ SSH port allowed in firewall"
else
    echo "ℹ UFW not found. Please manually configure firewall to allow SSH (port 22)"
fi

# System optimizations for low-cost hardware
echo ""
echo "[Step 6] System optimizations for low-cost hardware..."

# Disable unnecessary services to save resources
systemctl disable --now bluetooth.service 2>/dev/null || true
systemctl disable --now cups.service 2>/dev/null || true

# Configure swap for low-memory systems
if [ ! -f /swapfile ]; then
    echo "Do you want to create a 2GB swap file? (recommended for <4GB RAM) (y/n)"
    read -r create_swap

    if [[ "$create_swap" =~ ^[Yy]$ ]]; then
        fallocate -l 2G /swapfile
        chmod 600 /swapfile
        mkswap /swapfile
        swapon /swapfile
        echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab
        echo "✓ Swap file created"
    fi
fi

# Restart SSH service
echo ""
echo "[Step 7] Restarting SSH service..."
systemctl restart sshd
echo "✓ SSH service restarted"

# Summary
echo ""
echo "╔════════════════════════════════════════════════════════════════════════════╗"
echo "║                         Configuration Complete!                            ║"
echo "╚════════════════════════════════════════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo "  1. Run ./install.sh to install EduShare"
echo "  2. Change default student passwords for security"
echo "  3. Configure your network for thin client access"
echo "  4. Test SSH connection from a thin client"
echo ""
echo "Thin clients can connect with:"
echo "  ssh student001@<server-ip>"
echo "  (Replace <server-ip> with this server's IP address)"
echo ""
echo "To find this server's IP address, run: ip addr show"
echo ""
