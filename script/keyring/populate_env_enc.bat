@echo off

call .\script\conda\00_start_venv_miniconda_v1.bat

REM Populate base environment variables (from .env)
call .\script\99_set_env_base.bat

REM Decrypt and Populate environment variables (from .env.enc)
REM Retrieve the password securely
for /f "delims=" %%i in ('python .\script\keyring\get_key.py ENVENCKEY') do set enckey=%%i
@REM echo %enckey%

for /f "delims=" %%i in ('python .\script\keyring\get_key.py ENVENCIV') do set enciv=%%i
@REM echo %enciv%

for /f "delims=" %%a in ('openssl aes-256-cbc -d -in .env.enc -K %enckey% -iv %enciv% ^| findstr /V /B "#"') do (
    @set %%a
)