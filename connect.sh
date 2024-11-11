#!/bin/bash

PASSWORD="$1"
DEST_IP="$2"
USER="$3"

if [ -z "$PASSWORD" ] || [ -z "$DEST_IP" ] || [ -z "$USER" ]; then
  echo "Usage: ./connect.sh <password> <destination_ip> <user>"
  exit 1
fi

echo "Connecting to $DEST_IP as user $USER..."

# Ensure `plink` is installed and available
if ! command -v plink &> /dev/null; then
  echo "Error: plink is not installed."
  exit 1
fi

plink -ssh -pw "$PASSWORD" "$USER@$DEST_IP" "hostname; whoami; uptime"

if [ $? -eq 0 ]; then
  echo "Connection successful!"
else
  echo "Connection failed!"
  exit 1
fi
