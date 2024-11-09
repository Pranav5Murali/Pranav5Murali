import os

# Define the directory path you want to scan
path_dir = "/home/pranav/Documents"

try:
    # Check if the directory exists
    if not os.path.isdir(path_dir):
        print(f"Directory not found: {path_dir}")
        exit(1)

    # List all files in the directory
    arr_file = os.listdir(path_dir)

    # Filter out files with a '.log' extension
    arr = [j for j in arr_file if j.endswith(".log")]

    # Print the list of .log files found
    if arr:
        for j in arr:
            print(f"The file name is {j}\n")
    else:
        print("No .log files found in the directory.")

except Exception as e:
    print(f"An error occurred: {e}")
