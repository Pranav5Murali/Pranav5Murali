#!/bin/bash

# Usage: ./copy_and_execute.sh <dest_user> <dest_ip> <dest_password> <script_name>
DEST_USER="$1"
DEST_IP="$2"
DEST_PASSWORD="$3"
SCRIPT_NAME="$4"

# Define the destination path on the remote server explicitly
DEST_PATH="/home/$DEST_USER/git_target"

# Step 1: Copy the Python script to the remote server
echo "Copying Python script to $DEST_USER@$DEST_IP..."
sshpass -p "$DEST_PASSWORD" scp "./$SCRIPT_NAME" "$DEST_USER@$DEST_IP:$DEST_PATH"
COPY_STATUS=$?

if [ "$COPY_STATUS" == "0" ]; then
    echo "Python script copied successfully"
else
    echo "Error occurred while copying the script"
    exit 1
fi

# Step 2: Run the Python script on the remote server
echo "Running Python script on $DEST_USER@$DEST_IP..."
sshpass -p "$DEST_PASSWORD" ssh "$DEST_USER@$DEST_IP" "python3 $DEST_PATH/$SCRIPT_NAME"
EXECUTE_STATUS=$?

if [ "$EXECUTE_STATUS" == "0" ]; then
    echo "Successfully executed the Python script."
else
    echo "Error occurred while executing the script"
    exit 1
fi

echo "Operation completed successfully!"
exit 0
