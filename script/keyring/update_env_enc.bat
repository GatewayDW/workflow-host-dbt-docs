call .\script\conda\00_start_venv_miniconda_v1.bat
call .\script\keyring\decrypt_env.bat

:prompt
echo .env.dec is created, edit the content inside.
echo When finish editing, press Y. To cancel operation, press N.
choice /C YN /N /M "Select an option:"

if errorlevel 2 goto cancel
if errorlevel 1 goto continue

:continue
echo You have chosen to continue.
call python .\script\keyring\set_key.py
call python .\script\keyring\encrypt_env_base.py .env.dec
goto end

:cancel
echo Operation cancelled, you can encrypt the .env by running `python python .\script\keyring\encrypt_env_base.py .env.dec`
goto end

:end
