import keyring
import os
import base64
import secrets

def generate_key(bytes=32):
    # Generate a random key
    key = secrets.token_bytes(bytes)
    # Return the base64 encoded version of the key for easier storage and handling
    return base64.b64encode(key).decode('utf-8')
    # return key.hex()

def store_key(service_name, username, key_value):
    # print(key_value)
    # Store the key in the credential manager
    if keyring.get_password(service_name, username) is not None:
        # Update password
        keyring.delete_password(service_name, username)
        print(f"{service_name} exist, removing the existing one and replace with new key")
    keyring.set_password(service_name, username, key_value)
    print(f"{username} stored successfully to {service_name}")

# Get the current working directory
cwd = os.getcwd()

# Extract the last directory name from the cwd to use in the service name
directory_name = os.path.basename(cwd)

# Store the encryption key
key_value = generate_key(bytes=32)
store_key(
    service_name=f"ENVENCKEY@{directory_name}",
    username="ENVENCKEY",
    key_value=key_value
)

# Store the encryption IV
iv_value = generate_key(bytes=16)
store_key(
    service_name=f"ENVENCIV@{directory_name}",
    username="ENVENCIV",
    key_value=iv_value
)

# Set a 10 seconds later datetime in integer
from datetime import datetime, timedelta
key_rotation_offset_seconds = 10
rotation_datetime = int((datetime.now() + timedelta(seconds=key_rotation_offset_seconds)).timestamp())
store_key(
    service_name=f"ENVNEXTROTATE@{directory_name}",
    username="ENVNEXTROTATE",
    key_value=rotation_datetime
)