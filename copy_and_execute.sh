#!/bin/bash

# Usage: ./copy_and_execute.sh <dest_user> <dest_ip> <dest_password> <script_name>
DEST_USER="$1"
DEST_IP="$2"
DEST_PASSWORD="$3"
SCRIPT_NAME="$4"

# Define the destination path on the remote server
DEST_PATH="/home/karthik/git_target/$SCRIPT_NAME"

# Ensure the destination directory exists on the remote machine
echo "Creating destination directory on $DEST_USER@$DEST_IP..."
sshpass -p "$DEST_PASSWORD" ssh -o StrictHostKeyChecking=no "$DEST_USER@$DEST_IP" "mkdir -p /home/karthik/git_target"

# Copy the Python script from the GitHub Actions runner to the destination VM
echo "Copying Python script to $DEST_USER@$DEST_IP..."
sshpass -p "$DEST_PASSWORD" scp -o StrictHostKeyChecking=no "$SCRIPT_NAME" "$DEST_USER@$DEST_IP:$DEST_PATH"

# Check if the copy was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to copy the file using scp."
  exit 1
fi

# Run the Python script on the destination VM using ssh
echo "Executing Python script on $DEST_USER@$DEST_IP..."
sshpass -p "$DEST_PASSWORD" ssh -o StrictHostKeyChecking=no "$DEST_USER@$DEST_IP" "python3 $DEST_PATH"

if [ $? -eq 0 ]; then
  echo "Python script executed successfully!"
else
  echo "Error: Failed to execute the Python script."
  exit 1
fi
