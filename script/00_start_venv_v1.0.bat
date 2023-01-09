call "%~dp0project_config.cmd"

echo venv_root_dir = %venv_root_dir%
echo venv_name = %venv_name%

@REM How to trigger python using Anaconda3 in Windows?
@REM https://stackoverflow.com/questions/46437863/schedule-a-python-script-via-batch-on-windows-using-anaconda
call %venv_root_dir%\Scripts\activate.bat %venv_name%