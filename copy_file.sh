#!/bin/bash

DEST_USER="$1"
DEST_IP="$2"
DEST_PASSWORD="$3"
SCRIPT_NAME="$4"

if [ -z "$DEST_USER" ] || [ -z "$DEST_IP" ] || [ -z "$DEST_PASSWORD" ] || [ -z "$SCRIPT_NAME" ]; then
    echo "Usage: ./copy_file.sh <username> <ip_address> <password> <script_name>"
    exit 1
fi

DEST_PATH="/home/$DEST_USER/git_target"

sshpass -p "$DEST_PASSWORD" scp -o StrictHostKeyChecking=no "./$SCRIPT_NAME" "$DEST_USER@$DEST_IP:$DEST_PATH"
if [ $? -eq 0 ]; then
    echo "Python script copied successfully"
else
    echo "Error occurred while copying the script"
    exit 1
fi
