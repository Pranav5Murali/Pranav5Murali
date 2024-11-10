import os

# Remote server details
REMOTE_HOST = "192.168.1.100"
REMOTE_USER = "pranav"
REMOTE_PASSWORD = os.getenv("UBUNTU1") or "default_password"
TARGET_DIR = "/home/pranav/git_target/"
SCRIPT_NAME = "view_files.py"

def copy_script():
    if REMOTE_PASSWORD == "default_password":
        print("Error: Remote password not set. Check your environment variables.")
        return

    print("Copying script to remote server...")
    os.system(f'"C:\\Program Files\\PuTTY\\pscp.exe" -pw {REMOTE_PASSWORD} {SCRIPT_NAME} {REMOTE_USER}@{REMOTE_HOST}:{TARGET_DIR}{SCRIPT_NAME}')

def execute_script():
    if REMOTE_PASSWORD == "default_password":
        print("Error: Remote password not set. Check your environment variables.")
        return

    print("Running script on remote server...")
    os.system(f'"C:\\Program Files\\PuTTY\\plink.exe" -ssh {REMOTE_USER}@{REMOTE_HOST} -pw {REMOTE_PASSWORD} "python {TARGET_DIR}{SCRIPT_NAME}"')

if __name__ == "__main__":
    copy_script()
    execute_script()
