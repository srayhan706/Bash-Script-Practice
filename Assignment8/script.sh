#!/bin/bash

server_status() {

    local current_server="$HOSTNAME"

    if [ "$current_server" != "MDs-MacBook-Air.local" ]; then
        echo "This script can only run on server: MDs-MacBook-Air.local"
        return 1
    fi

    echo "Server Name:"
    echo "$current_server"
    echo

    echo "Server Uptime:"
    uptime -p
    echo

    echo "Logged In Users:"
    who
    echo

    echo "Checking nginx Process:"
    ps -ef | grep nginx | grep -v grep
    echo

    echo "RAM Usage:"
    free -h
    echo

    echo "Processor Usage:"
    top -bn1 | grep "Cpu(s)"
    echo

    echo "IP Address:"
    hostname -I
    echo

    echo "Checking Google Connectivity:"
    ping -c 1 google.com
}

server_status