#!/bin/bash

# Hardcoded variables
DEST_USER="karthik"
DEST_IP="192.168.1.105"
DEST_PASSWORD="$1"
SCRIPT_NAME="$2"


# Define the destination path on the remote server
DEST_PATH="/home/$DEST_USER/git_target"

echo "Copying Python script to $DEST_USER@$DEST_IP..."

# Copy the Python script to the remote server using sshpass and scp
sshpass -p "$DEST_PASSWORD" scp -o StrictHostKeyChecking=no "./$SCRIPT_NAME" "$DEST_USER@$DEST_IP:$DEST_PATH"
COPY_STATUS=$?

# Check if the script was copied successfully
if [ "$COPY_STATUS" -eq 0 ]; then
    echo "Python script copied successfully"
else
    echo "Error occurred while copying the script"
    exit 1
fi
