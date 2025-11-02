# EduShare Learning System

**Education for Everyone, Everywhere**

A lightweight, SSH-based learning management system designed specifically for underprivileged schools with limited resources. Students access educational materials through thin clients connected to a central server via SSH.

---

##  Purpose

EduShare solves the challenge of providing quality educational content in resource-constrained environments by:

- **Minimizing costs**: Uses a single low-cost server and basic thin clients
- **Maximizing access**: Multiple students can access materials from different locations
- **Enabling offline learning**: Students download materials to read without staying connected
- **Reducing complexity**: Simple text-based interface works on any terminal

---

##  Features

-  **Subject-organized content** - Mathematics, Science, English, History, and more
-  **Beautiful terminal UI** - Color-coded, easy-to-read formatting
-  **Offline downloads** - Students save materials locally to free up server access
-  **Read-only access** - Students can't modify server files
-  **Lightweight** - Minimal resource usage, perfect for low-cost hardware
-  **Multi-user** - Many students can SSH in simultaneously
-  **Self-paced learning** - Students browse and read at their own pace

---

##  System Architecture

```
┌─────────────────┐
│  Thin Client 1  │───┐
└─────────────────┘   │
                      │  SSH
┌─────────────────┐   │  Connection
│  Thin Client 2  │───┼────────►  ┌──────────────────────┐
└─────────────────┘   │           │   EduShare Server    │
                      │           │  (Low-cost device)   │
┌─────────────────┐   │           │                      │
│  Thin Client 3  │───┘           │  - Learning Content  │
└─────────────────┘               │  - User Management   │
                                  │  - SSH Service       │
                                  └──────────────────────┘

Student Workflow:
1. SSH into server
2. Run 'learn' command
3. Browse subjects and lessons
4. Download materials for offline reading
5. Disconnect (free up session for others)
6. Read downloaded materials offline
```

---

##  What's Included

```
learning-system/
├── materials/              # Educational content repository
│   ├── mathematics/
│   │   ├── lessons/       # Math lessons in .txt format
│   │   └── resources/     # Additional resources
│   ├── science/
│   │   ├── lessons/
│   │   └── resources/
│   ├── english/
│   │   ├── lessons/
│   │   └── resources/
│   └── history/
│       ├── lessons/
│       └── resources/
├── learn.sh               # Main student interface
├── install.sh             # Installation script
├── server-setup.sh        # Server configuration helper
├── add-content.sh         # Content management tool
├── README.md              # This file
├── SETUP_GUIDE.md         # Detailed setup instructions
└── CONTENT_GUIDE.md       # Guide for creating learning materials
```

---

##  Quick Start

### For Server Administrators

1. **Configure the server**:
   ```bash
   sudo ./server-setup.sh
   ```

2. **Install EduShare**:
   ```bash
   sudo ./install.sh
   ```

3. **Add more content** (optional):
   ```bash
   ./add-content.sh add-subject geography
   ./add-content.sh add-lesson geography my-lesson.txt
   ```

### For Students

1. **Connect via SSH**:
   ```bash
   ssh student001@<server-ip>
   ```

2. **Launch EduShare**:
   ```bash
   learn
   ```

3. **Browse and download materials**, then disconnect to let others use the server

4. **Read offline**:
   ```bash
   cat ~/my-learning-materials/mathematics/lessons/01_basic_arithmetic.txt
   ```

---

##  Hardware Requirements

### Server
- **Minimum**: Raspberry Pi 3, or any PC with 2GB RAM
- **Recommended**: Raspberry Pi 4 (4GB RAM) or low-cost PC with 4GB+ RAM
- **Storage**: 8GB+ (depends on content volume)
- **Network**: Ethernet connection (WiFi acceptable)

### Thin Clients
- Any device capable of SSH connection
- Examples:
  - Raspberry Pi Zero W
  - Old computers repurposed as thin clients
  - Chromebooks in developer mode
  - Any Linux/Windows/Mac computer

---

## 🔧 Technical Specifications

- **Language**: Bash (no dependencies beyond standard Linux tools)
- **Protocol**: SSH
- **Content Format**: Plain text (.txt files)
- **User Interface**: Terminal-based with ANSI color support
- **Concurrent Users**: 50+ (configurable)
- **Resource Usage**:
  - Per SSH session: ~5-10MB RAM
  - Base system: ~500MB RAM
  - Storage: ~100KB per lesson

---

##  Adding Your Own Content

### Content Format

Lessons are stored as plain text files with simple formatting:

```
================================================================================
                           LESSON TITLE
================================================================================

Section Header
--------------

Content goes here...

Examples:
  Example 1
  Example 2

Practice Problems:
1. Question 1
2. Question 2

Answers: 1) Answer1  2) Answer2

Key Points:
* Point 1
* Point 2
================================================================================
```

### Adding Content

```bash
# Create a new subject
./add-content.sh add-subject geography

# Add a lesson
./add-content.sh add-lesson geography my-geography-lesson.txt

# List all content
./add-content.sh list
```

See `CONTENT_GUIDE.md` for detailed formatting guidelines.

---

##  Security Considerations

1. **Change default passwords** - The setup creates accounts with password "student"
   ```bash
   sudo passwd student001
   ```

2. **Use SSH keys** (recommended for better security)
   ```bash
   ssh-keygen
   ssh-copy-id student001@server-ip
   ```

3. **Keep system updated**
   ```bash
   sudo apt update && sudo apt upgrade
   ```

4. **Monitor resource usage**
   ```bash
   htop  # Install with: sudo apt install htop
   ```

5. **Regular backups** of materials directory
   ```bash
   tar -czf edushare-backup-$(date +%Y%m%d).tar.gz /opt/edushare/materials
   ```

---

##  Use Cases

### In the Classroom
- Teacher demonstrates lessons on projector
- Students follow along on thin clients
- Download materials for homework

### Computer Lab
- Self-paced learning
- Multiple students access different subjects
- Offline reading reduces server load

### Home Access
- Students SSH from home (if internet available)
- Download weekly materials
- Study offline during week

---

##  Troubleshooting

### Students can't connect via SSH
```bash
# Check if SSH service is running
sudo systemctl status sshd

# Check server IP address
ip addr show

# Check firewall
sudo ufw status
```

### Terminal colors not showing
- Some terminals don't support colors
- The interface works fine in black & white
- Try a different terminal emulator

### Server running slow
```bash
# Check connected users
who

# Check system resources
htop

# Ask students to download materials and disconnect
```

---

##  Documentation

- `README.md` - This file (overview and quick start)
- `SETUP_GUIDE.md` - Detailed setup instructions
- `CONTENT_GUIDE.md` - Creating and formatting learning materials
- `TROUBLESHOOTING.md` - Common issues and solutions

---

##  Contributing Content

Teachers and educators are encouraged to contribute learning materials!

1. Create lessons following the content format guidelines
2. Test them with the interface
3. Share with other schools implementing EduShare

---

##  License

This project is released into the public domain for educational purposes.
Schools and educators are free to use, modify, and distribute without restriction.

---

##  Project Goals

EduShare aims to:
- Reduce educational inequality through technology
- Maximize learning opportunities with minimal resources
- Empower teachers to create and share content
- Enable students to learn at their own pace
- Demonstrate that effective e-learning doesn't require expensive hardware

---

##  Tips for Success

1. **Start small** - Install with example content, then gradually add more
2. **Train students** - Teach proper usage (download and disconnect)
3. **Regular backups** - Protect your educational content
4. **Community approach** - Teachers collaborate on creating content
5. **Monitor usage** - Adjust server capacity as needed

---

##  Support

For issues, questions, or contributions:
- Check `TROUBLESHOOTING.md`
- Review documentation files
- Consult with your IT support

---

**Built with  for underprivileged schools worldwide**

*Education is the most powerful weapon which you can use to change the world.* - Nelson Mandela
