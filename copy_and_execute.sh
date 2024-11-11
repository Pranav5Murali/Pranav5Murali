#!/bin/bash

# Usage: ./copy_and_execute.sh <source_user> <source_ip> <source_password> <dest_user> <dest_ip> <source_script_path>
SOURCE_USER="$1"
SOURCE_IP="$2"
SOURCE_PASSWORD="$3"
DEST_USER="$4"
DEST_IP="$5"
SOURCE_SCRIPT_PATH="$6"

# Define the destination path on the remote server
DEST_PATH="/home/karthik/git_target/view_files.py"

# Validate inputs
if [ -z "$SOURCE_USER" ] || [ -z "$SOURCE_IP" ] || [ -z "$SOURCE_PASSWORD" ] || [ -z "$DEST_USER" ] || [ -z "$DEST_IP" ] || [ -z "$SOURCE_SCRIPT_PATH" ]; then
  echo "Usage: ./copy_and_execute.sh <source_user> <source_ip> <source_password> <dest_user> <dest_ip> <source_script_path>"
  exit 1
fi

# Ensure the destination directory exists on the remote machine
echo "Creating destination directory on $DEST_USER@$DEST_IP..."
sshpass -p "$SOURCE_PASSWORD" ssh -o StrictHostKeyChecking=no "$DEST_USER@$DEST_IP" "mkdir -p /home/karthik/git_target"

# Copy the Python script to the destination VM using scp
echo "Copying Python script to $DEST_USER@$DEST_IP..."
sshpass -p "$SOURCE_PASSWORD" scp -o StrictHostKeyChecking=no "$SOURCE_SCRIPT_PATH" "$DEST_USER@$DEST_IP:$DEST_PATH"

# Check if the copy was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to copy the file using scp."
  exit 1
fi

# Run the Python script on the destination VM using ssh
echo "Executing Python script on $DEST_USER@$DEST_IP..."
sshpass -p "$SOURCE_PASSWORD" ssh -o StrictHostKeyChecking=no "$DEST_USER@$DEST_IP" "python3 $DEST_PATH"

if [ $? -eq 0 ]; then
  echo "Python script executed successfully!"
else
  echo "Error: Failed to execute the Python script."
  exit 1
fi
