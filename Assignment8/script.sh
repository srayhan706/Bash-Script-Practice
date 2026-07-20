#!/bin/bash

# Only allow the script to run on a specific server
SERVER_NAME="MDs-MacBook-Air.local"      # Change this to your server's hostname

HOST=$(hostname)

if [ "$HOST" != "$SERVER_NAME" ]; then
    echo "Error: This script can only run on $SERVER_NAME."
    exit 1
fi

echo "========== System Information =========="

# How long the server has been running
echo
echo "Server Uptime:"
uptime

# Logged in users
echo
echo "Logged in Users:"
who

# Search for a specific process
PROCESS="sshd"      # Change to the process you want

echo
echo "Searching for process: $PROCESS"

if pgrep "$PROCESS" > /dev/null
then
    echo "Process '$PROCESS' is running."
    ps -fp $(pgrep "$PROCESS")
else
    echo "Process '$PROCESS' is NOT running."
fi

# RAM usage
echo
echo "Memory Usage:"
free -h 2>/dev/null || vm_stat

# CPU usage
echo
echo "CPU Information:"
top -l 1 | grep "CPU usage" 2>/dev/null || top -bn1 | grep "Cpu(s)"

# IP Address
echo
echo "IP Address:"
hostname -I 2>/dev/null || ifconfig | grep "inet "

# Test Internet connectivity
read -p "Enter a website or IP to test connectivity: " HOST

echo "Checking connectivity to $HOST..."

if ping -c 4 "$HOST" > /dev/null 2>&1; then
    echo "$HOST is reachable."
else
    echo "$HOST is NOT reachable."
    exit 1
fi