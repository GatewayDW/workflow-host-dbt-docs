import keyring
import os
import sys
import base64

def check_key_rotation():
    # Get the current working directory
    cwd = os.getcwd()

    # Extract the last directory name from the cwd to use in the service name
    directory_name = os.path.basename(cwd)

    # Construct the service name dynamically
    service_name = f"ENVNEXTROTATE@{directory_name}"
    current_time = int(datetime.now().timestamp())
    next_rotate = keyring.get_password(service_name, "ENVNEXTROTATE")

    if current_time >= next_rotate:
        print(f"{current_time} >= {next_rotate}")
        
    else:
        sys.exit(1)

def get_key(keyname):
    # Get the current working directory
    cwd = os.getcwd()

    # Extract the last directory name from the cwd to use in the service name
    # This assumes you're calling the script from the project directory
    directory_name = os.path.basename(cwd)

    # Construct the service name dynamically
    service_name = f"{keyname}@{directory_name}"
    key = base64.b64decode(keyring.get_password(service_name, keyname))

    if key:
        print(key.hex())
    else:
        print("Key not found.", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python get_key.py keyname")
        sys.exit(1)

    keyname = sys.argv[1]
    get_key(keyname)
