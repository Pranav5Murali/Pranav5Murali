#!/bin/bash

# Usage: ./copy_and_execute.sh <source_user> <source_ip> <source_password> <dest_user> <dest_ip> <script_path>
SOURCE_USER="$1"
SOURCE_IP="$2"
SOURCE_PASSWORD="$3"
DEST_USER="$4"
DEST_IP="$5"
SCRIPT_PATH="$6"

# Define the destination path on the remote server
DEST_PATH="/home/karthik/git_target/view_files.py"

# Validate inputs
if [ -z "$SOURCE_USER" ] || [ -z "$SOURCE_IP" ] || [ -z "$SOURCE_PASSWORD" ] || [ -z "$DEST_USER" ] || [ -z "$DEST_IP" ] || [ -z "$SCRIPT_PATH" ]; then
  echo "Usage: ./copy_and_execute.sh <source_user> <source_ip> <source_password> <dest_user> <dest_ip> <script_path>"
  exit 1
fi

# Copy the Python script using scp
echo "Copying Python script to destination VM..."
sshpass -p "$SOURCE_PASSWORD" scp "$SOURCE_USER@$SOURCE_IP:$SCRIPT_PATH" "$DEST_USER@$DEST_IP:$DEST_PATH"

# Check if the copy was successful
if [ $? -ne 0 ]; then
  echo "Error: Failed to copy the file."
  exit 1
fi

# Run the Python script on the destination VM using ssh
echo "Executing Python script on destination VM..."
sshpass -p "$SOURCE_PASSWORD" ssh -o StrictHostKeyChecking=no "$DEST_USER@$DEST_IP" "python3 $DEST_PATH"

# Check if the execution was successful
if [ $? -eq 0 ]; then
  echo "Python script executed successfully!"
else
  echo "Error: Failed to execute the Python script."
  exit 1
fi
