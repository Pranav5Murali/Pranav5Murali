#!/bin/bash

# Usage: ./connect.sh <password> <destination_ip> <user>

PASSWORD="$1"
DEST_IP="$2"
USER="$3"

# Validate inputs
if [ -z "$PASSWORD" ] || [ -z "$DEST_IP" ] || [ -z "$USER" ]; then
  echo "Usage: ./connect.sh <password> <destination_ip> <user>"
  exit 1
fi

# Check if expect is installed
if ! command -v expect &> /dev/null; then
  echo "Error: 'expect' is not installed. Installing it..."
  sudo apt update && sudo apt install -y expect
fi

# Use expect to handle SSH connection with the password
expect <<EOF
spawn ssh -o StrictHostKeyChecking=no "$USER@$DEST_IP" "hostname; whoami; uptime"
expect "password:"
send "$PASSWORD\r"
expect eof
EOF

# Check if the connection was successful
if [ $? -eq 0 ]; then
  echo "Connection to $DEST_IP successful!"
else
  echo "Connection to $DEST_IP failed!"
  exit 1
fi
