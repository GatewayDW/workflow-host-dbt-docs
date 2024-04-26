call .\script\99_set_env_base.bat
echo %%MINICONDA_PATH%%=%MINICONDA_PATH%
echo %%MINICONDA_VENV%%=%MINICONDA_VENV%

echo Spinning up virtual environment: %MINICONDA_VENV%...
call %MINICONDA_PATH% %MINICONDA_VENV%