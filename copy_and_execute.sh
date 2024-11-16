#!/bin/bash

# Usage: ./copy_and_execute.sh <dest_user> <dest_ip> <dest_password> <script_name>
DEST_USER="$1"
DEST_IP="$2"
DEST_PASSWORD="$3"
SCRIPT_NAME="$4"

# Define the destination path on the remote server
DEST_PATH="/home/$DEST_USER/git_target"

# Copy the Python script to the remote server
sshpass -p "$DEST_PASSWORD" scp -o StrictHostKeyChecking=no "./$SCRIPT_NAME" "$DEST_USER@$DEST_IP:$DEST_PATH"
COPY_STATUS=$?

if [ "$COPY_STATUS" == "0" ]; then
    echo "Python script copied successfully"
else
    echo "Error occurred while copying the script"
    exit 1
fi
