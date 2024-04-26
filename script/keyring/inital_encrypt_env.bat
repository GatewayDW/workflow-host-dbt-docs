call .\script\conda\00_start_venv_miniconda_v1.bat
call python .\script\keyring\set_key.py
echo ".env is copied from .env.sample"
copy .env.sample .env
call python .\script\keyring\encrypt_env_base.py .env
echo ".env is encrypted to .env.enc, and the original file is deleted."
echo "Run .\script\keyring\update_env_enc.bat if you need to modify content inside .env.enc"