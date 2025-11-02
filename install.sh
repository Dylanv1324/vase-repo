#!/bin/bash

# EduShare Installation Script
# This script installs the EduShare learning system on a server

set -e

echo "╔════════════════════════════════════════════════════════════════════════════╗"
echo "║                    EduShare Learning System Installer                      ║"
echo "╚════════════════════════════════════════════════════════════════════════════╝"
echo ""

# Configuration
INSTALL_DIR="/opt/edushare"
MATERIALS_DIR="$INSTALL_DIR/materials"
BIN_DIR="/usr/local/bin"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)"
    exit 1
fi

echo "[1/5] Creating installation directory..."
mkdir -p "$INSTALL_DIR"

echo "[2/5] Copying materials and scripts..."
cp -r ./materials "$INSTALL_DIR/"
cp ./learn.sh "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/learn.sh"

echo "[3/5] Creating symbolic link..."
ln -sf "$INSTALL_DIR/learn.sh" "$BIN_DIR/learn"

echo "[4/5] Setting permissions..."
chmod -R 755 "$INSTALL_DIR"
find "$MATERIALS_DIR" -type f -exec chmod 644 {} \;

echo "[5/5] Creating welcome message..."
cat > /etc/motd << 'EOF'
╔════════════════════════════════════════════════════════════════════════════╗
║                         Welcome to EduShare Server                         ║
║                    Education for Everyone, Everywhere                      ║
╚════════════════════════════════════════════════════════════════════════════╝

To access learning materials, type: learn

For help, type: learn (then select Help from the menu)

Remember to download materials for offline reading so others can use the server!

EOF

echo ""
echo "Installation complete!"
echo ""
echo "Students can now run 'learn' to access educational materials."
echo "Installation location: $INSTALL_DIR"
echo ""
echo "Next steps:"
echo "  1. Add learning materials to: $MATERIALS_DIR"
echo "  2. Create student accounts (if needed)"
echo "  3. Configure SSH server for thin client access"
echo ""
