@echo off

for /f "delims=" %%i in ('python .\script\keyring\get_key.py ENVENCKEY') do set enckey=%%i

for /f "delims=" %%i in ('python .\script\keyring\get_key.py ENVENCIV') do set enciv=%%i

REM Decrypt the .env file
openssl aes-256-cbc -d -in .env.enc -out .env.dec -K %enckey% -iv %enciv%
