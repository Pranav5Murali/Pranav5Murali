#!/bin/bash

# Fetch the secret from the environment variable
PASSWORD="${UBUNTU1}"

# Check if the password is fetched successfully
if [ -z "$PASSWORD" ]; then
  echo "Error: Secret UBUNTU1 is empty or not accessible"
  exit 1
else
  echo "Secret UBUNTU1 fetched successfully"
  export PASSWORD
fi
