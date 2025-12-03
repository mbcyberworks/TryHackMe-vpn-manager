#!/usr/bin/env bash
# ============================================================================
# TryHackMe VPN Manager - by MB Cyberworks
# ============================================================================
# Usage:
#   tryhackme start   → start VPN
#   tryhackme stop    → stop VPN
#   tryhackme status  → check if VPN is active
# ============================================================================

# Change the folder where the ovpn is
CONFIG="/home/kalimau/Documents/Tryhackme/xxxxx.ovpn"
PIDFILE="/tmp/tryhackme-vpn.pid"
LOGFILE="/tmp/tryhackme-vpn.log"

validate_config() {
    if [ ! -f "$CONFIG" ]; then
        echo "❌ Config file not found: $CONFIG"
        echo "📍 Please ensure your OpenVPN config is in the correct location."
        exit 1
    fi
}

start_vpn() {
    validate_config
    
    if pgrep -f "openvpn.*${CONFIG}" >/dev/null; then
        echo "🔗 TryHackMe VPN is already running."
        exit 0
    fi
    
    echo "🚀 Starting TryHackMe VPN..."
    sudo openvpn --config "$CONFIG" --daemon --writepid "$PIDFILE" --log "$LOGFILE"
    sleep 2
    
    if pgrep -f "openvpn.*${CONFIG}" >/dev/null; then
        echo "✅ VPN connected successfully!"
    else
        echo "❌ Failed to start VPN. Check $LOGFILE for details."
    fi
}

stop_vpn() {
    if [ -f "$PIDFILE" ]; then
        echo "🛑 Stopping TryHackMe VPN..."
        if sudo kill "$(cat "$PIDFILE")" 2>/dev/null; then
            rm -f "$PIDFILE"
            echo "✅ VPN disconnected."
        else
            echo "❌ Failed to stop VPN process."
            rm -f "$PIDFILE"  # Clean up stale PID file
        fi
    else
        echo "ℹ️ VPN not running or PID file missing."
    fi
}

status_vpn() {
    if pgrep -f "openvpn.*${CONFIG}" >/dev/null; then
        echo "✅ VPN is currently running."
        # Optional: Show connection info
        if command -v ip >/dev/null 2>&1; then
            THM_IP=$(ip addr show tun0 2>/dev/null | grep -o 'inet [0-9.]*' | cut -d' ' -f2)
            if [ -n "$THM_IP" ]; then
                echo "📡 TryHackMe IP: $THM_IP"
            fi
        fi
    else
        echo "❌ VPN is not running."
    fi
}

case "$1" in
    start) start_vpn ;;
    stop) stop_vpn ;;
    status) status_vpn ;;
    *)
        echo "Usage: tryhackme {start|stop|status}"
        echo ""
        echo "Commands:"
        echo "  start   - Connect to TryHackMe VPN"
        echo "  stop    - Disconnect from TryHackMe VPN" 
        echo "  status  - Show current VPN status"
        exit 1
        ;;
esac
