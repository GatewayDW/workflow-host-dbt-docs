import os
import sys
import base64
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import padding
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
import keyring

def encrypt_file(file_path, service_base_name):
    service_name_key = "ENVENCKEY" + "@" + service_base_name
    service_name_iv = "ENVENCIV" + "@" + service_base_name

    # Retrieve the key and IV from the Credential Manager
    key = base64.b64decode(keyring.get_password(service_name_key, "ENVENCKEY"))
    iv = base64.b64decode(keyring.get_password(service_name_iv, "ENVENCIV"))

    # Convert key and IV to hexadecimal for OpenSSL compatibility
    key_hex = key.hex()
    iv_hex = iv.hex()

    # Initialize cipher
    print(f"Encrypting file: {file_path}")
    print(f"Key: {service_name_key}")
    print(f"IV: {service_name_iv}")
    cipher = Cipher(algorithms.AES(key), modes.CBC(iv), backend=default_backend())
    encryptor = cipher.encryptor()
    
    # Read the file content
    with open(file_path, 'rb') as f:
        file_data = f.read()

    # Pad the file_data to be a multiple of block size
    padder = padding.PKCS7(algorithms.AES.block_size).padder()
    padded_data = padder.update(file_data) + padder.finalize()

    # Encrypt the data
    encrypted_data = encryptor.update(padded_data) + encryptor.finalize()

    # Save the encrypted data to a new file
    # encrypted_file_path = file_path + '.enc'
    encrypted_file_path = '.env.enc'
    with open(encrypted_file_path, 'wb') as f:
        f.write(encrypted_data)
    
    print(f"File encrypted: {encrypted_file_path}")

def delete_env_file(env_file_path):
    # Ask the user whether to delete the .env file or not
    user_input = input("Do you want to delete the .env file? [Y/n] (Default: Y): ").strip().lower()
    # Default to 'yes' if the user presses enter without typing anything
    if user_input in ['', 'y', 'yes']:
        try:
            os.remove(env_file_path)
            print(".env file has been deleted successfully.")
        except OSError as e:
            print(f"Error: {e.strerror} - {e.filename}")
    else:
        print(".env file was not deleted.")

# Example usage
if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python encrypt_env_base.py path_to_env_file")
        sys.exit(1)
    
    path_to_file = sys.argv[1]

    # Get the current working directory
    cwd = os.getcwd()

    # Extract the last directory name from the cwd to use in the service name
    # This assumes you're calling the script from the project directory
    directory_name = os.path.basename(cwd)
    encrypt_file(path_to_file, service_base_name=directory_name)

    # Optional: Remove the original .env file
    delete_env_file(path_to_file)
