# TryHackMe VPN Manager

A simple bash script to manage TryHackMe VPN connections from the command line.

## 🔧 Features

- **Easy VPN management**: Start, stop, and check VPN status with simple commands
- **Process validation**: Prevents multiple VPN instances
- **Config file validation**: Ensures OpenVPN configuration exists
- **Clean logging**: Maintains logs for troubleshooting
- **Status monitoring**: Shows connection status and tunnel IP address
- **Daemon mode**: Runs VPN in background

## 📋 Prerequisites

- Linux system (tested on Kali Linux)
- OpenVPN installed (`sudo apt install openvpn`)
- TryHackMe OpenVPN configuration file
- Sudo privileges for OpenVPN operations

## 🚀 Installation

1. Clone this repository:
```bash
git clone https://github.com/mbcyberworks/TryHackMe-vpn-manager.git
cd tryhackme-vpn-manager
```

2. Make the script executable:
```bash
chmod +x tryhackme
```

3. Move to system PATH (optional):
```bash
sudo cp tryhackme /usr/local/bin/
```

4. Update the config path in the script to match your TryHackMe OpenVPN file location:
```bash
CONFIG="/path/to/your/tryhackme-config.ovpn"
```

## 📖 Usage

```bash
# Start VPN connection
tryhackme start

# Stop VPN connection  
tryhackme stop

# Check VPN status
tryhackme status
```

### Example Output

```bash
$ tryhackme start
🚀 Starting TryHackMe VPN...
✅ VPN connected successfully!

$ tryhackme status
✅ VPN is currently running.
📡 TryHackMe IP: 10.x.x.x

$ tryhackme stop
🛑 Stopping TryHackMe VPN...
✅ VPN disconnected.
```

## ⚙️ Configuration

Edit the script to update these variables according to your setup:

- `CONFIG`: Path to your TryHackMe OpenVPN configuration file
- `PIDFILE`: Location for the process ID file (default: `/tmp/tryhackme-vpn.pid`)
- `LOGFILE`: Location for OpenVPN logs (default: `/tmp/tryhackme-vpn.log`)

## 🔍 Troubleshooting

- **"Config file not found"**: Ensure the `CONFIG` path points to your TryHackMe `.ovpn` file
- **"Failed to start VPN"**: Check the log file specified in `LOGFILE` for OpenVPN errors
- **Permission issues**: Ensure you have sudo privileges for OpenVPN operations

## 🤝 Contributing

Contributions are welcome! Feel free to:

- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**MB Cyberworks** - Ethical Hacker in Development
- Blog: [mbcyberworks.nl](https://mbcyberworks.nl)
- Currently preparing for PNPT certification

## ⚠️ Disclaimer

This tool is intended for legitimate cybersecurity learning and practice on platforms like TryHackMe. Always ensure you have proper authorization before conducting any security testing activities.

---

*Part of my cybersecurity learning journey. Check out more tools and write-ups on my [blog](https://mbcyberworks.nl).*
