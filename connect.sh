#!/bin/bash

# Usage: ./connect.sh <password> <destination_ip> <user>
PASSWORD="$1"
DEST_IP="$2"
USER="$3"

# Check if all arguments are provided
if [ -z "$PASSWORD" ] || [ -z "$DEST_IP" ] || [ -z "$USER" ]; then
  echo "Usage: ./connect.sh <password> <destination_ip> <user>"
  exit 1
fi

echo "Attempting to connect to $DEST_IP as user $USER..."

# Check if plink is installed
if ! command -v plink &> /dev/null; then
  echo "Error: plink is not installed. Please install it before running this script."
  exit 1
fi

# Attempt to connect using plink
plink -ssh -pw "$PASSWORD" "$USER@$DEST_IP" "hostname; whoami; uptime"

# Check if the connection was successful
if [ $? -eq 0 ]; then
  echo "Connection to $DEST_IP successful!"
else
  echo "Connection to $DEST_IP failed!"
  exit 1
fi
