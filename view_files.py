import os

path_dir ="/home/pranav/Documents"

arr = []
arr_file = os.listdir(path_dir)

for j in arr_file:
    if j.endswith(".log"):  # Added a colon at the end of the if statement
        arr.append(j)

for j in arr:
    print("The file name is " + j + "\n")  # Added a space for better formatting
