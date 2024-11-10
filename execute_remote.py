import os

# Remote server details
REMOTE_HOST = "192.168.1.100"
REMOTE_USER = "pranav"
REMOTE_PASSWORD = os.getenv("UBUNTU1") or "default_password"
TARGET_DIR = "/home/pranav/git_target/"
SCRIPT_NAME = "view_files.py"

def copy_and_execute_script():
    if REMOTE_PASSWORD == "default_password":
        print("Error: Remote password not set. Check your environment variables.")
        return

    print("Copying script to remote server and executing...")
    # Use plink to copy and execute the script remotely
    os.system(f'"C:\\Program Files\\PuTTY\\plink.exe" -ssh {REMOTE_USER}@{REMOTE_HOST} -pw {REMOTE_PASSWORD} '
              f'"mkdir -p {TARGET_DIR} && cat > {TARGET_DIR}{SCRIPT_NAME}" < {SCRIPT_NAME}')

    print("Running script on remote server...")
    os.system(f'"C:\\Program Files\\PuTTY\\plink.exe" -ssh {REMOTE_USER}@{REMOTE_HOST} -pw {REMOTE_PASSWORD} '
              f'"python3 {TARGET_DIR}{SCRIPT_NAME}"')

if __name__ == "__main__":
    copy_and_execute_script()
