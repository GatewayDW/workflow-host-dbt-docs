call .\script\99_set_env_base.bat

echo %%MINICONDA_PATH%%=%MINICONDA_PATH%

echo Spinning up virtual environment: base...
call %MINICONDA_PATH% base