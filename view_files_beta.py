import os

path_dir = "/home/karthik/git_target"


if not os.path.exists(path_dir):
    print(f"Directory '{path_dir}' does not exist. Creating it...")
    os.makedirs(path_dir)
else:
    print(f"Directory '{path_dir}' already exists.")

# Step 2: List all files in the directory and filter for .log files
arr = []
arr_file = os.listdir(path_dir)

print("This is the Beta Branch")

for j in arr_file:
    if j.endswith(".log"):
        arr.append(j)

for j in arr:
    print("The file name is " + j + "\n")
