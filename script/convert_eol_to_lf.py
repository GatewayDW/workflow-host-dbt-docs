import os
import codecs

# Function to check if bytes are text characters
textchars = bytearray({7, 8, 9, 10, 12, 13, 27} | set(range(0x20, 0x100)) - {0x7f})
is_binary = lambda bytes: bool(bytes.translate(None, textchars))

def convert_to_LF(file_path):
    # Read the file content
    with codecs.open(file_path, 'r', encoding='utf-8', errors='ignore') as file:
        content = file.read()
    
    # Convert line endings to LF
    content = content.replace('\r\n', '\n')

    # Write the converted content back to the file
    with codecs.open(file_path, 'w', encoding='utf-8') as file:
        file.write(content)

def convert_directory_to_LF(directory_path):
    # Check if the path is a directory
    if os.path.isdir(directory_path):
        # Iterate through all files in the directory and its subdirectories
        for root, dirs, files in os.walk(directory_path):
            # Exclude .git directory
            if '.git' in dirs:
                dirs.remove('.git')
            for file_name in files:
                file_path = os.path.join(root, file_name)
                with open(file_path, 'rb') as file:
                    if not is_binary(file.read(1024)):
                        convert_to_LF(file_path)
        print("Conversion complete!")
    # Check if the path is a file
    elif os.path.isfile(directory_path):
        # Convert single file to LF
        with open(directory_path, 'rb') as file:
            if not is_binary(file.read(1024)):
                convert_to_LF(directory_path)
                print("Conversion complete!")
            else:
                print("Error: The specified file is binary and cannot be converted.")
    else:
        print("Error: The specified path does not exist.")

# Prompt the user to input the target directory or file
path = input("Enter the path to the target directory or file: ")

# Convert either directory or file to LF
convert_directory_to_LF(path)
