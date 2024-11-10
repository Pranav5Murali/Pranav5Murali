import os
import subprocess

def copy_script_to_remote():
    username = os.getenv("USERNAME")
    host = os.getenv("HOST")
    password = os.getenv("PASSWORD")
    target_dir = os.getenv("TARGET_DIR")
    local_script = os.getenv("LOCAL_SCRIPT")

    print(f"Copying Python script to {host}...")
    copy_cmd = f'sshpass -p "{password}" scp -o StrictHostKeyChecking=no {local_script} {username}@{host}:{target_dir}/'
    subprocess.run(copy_cmd, shell=True, check=True)

def execute_script_on_remote():
    username = os.getenv("USERNAME")
    host = os.getenv("HOST")
    password = os.getenv("PASSWORD")
    remote_script = os.getenv("REMOTE_SCRIPT")

    print(f"Executing Python script on {host} using python3...")
    exec_cmd = f'sshpass -p "{password}" ssh -o StrictHostKeyChecking=no {username}@{host} "/usr/bin/python3 {remote_script}"'
    result = subprocess.run(exec_cmd, shell=True, capture_output=True, text=True)
    
    if result.returncode != 0:
        print(f"Error: {result.stderr}")
        exit(1)
    else:
        print(f"Success: {result.stdout}")

if __name__ == "__main__":
    copy_script_to_remote()
    execute_script_on_remote()
