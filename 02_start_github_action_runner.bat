@REM This script is for the situation when Docker is not used.
@REM Run this script using cmd terminal and in the project root directory

call .\script\99_set_env_base.bat
call .\script\conda\00_start_venv_miniconda_v1.bat

@REM Start the GitHub Actions Self-Hosted Runner
cd %GITHUB_ACTION_RUN_PATH%
@REM call %GITHUB_ACTION_RUN_PATH%\run.cmd --token %RUNNER_TOKEN%

REM If the runner version is too old, Follow the steps in https://github.com/organizations/GatewayDW/settings/actions/runners/new?arch=x64&os=win
REM After downloading and extracting the latest runner, follow the below steps:
REM Step 1: Archive the current runner folder (Add _bak to the folder name)
REM Step 2: Change the RUNNER_TOKEN in the .env file to the new token
REM Step 3: Configure the new runner by running the following commands (See readme for details):
REM call .\script\99_set_env_base.bat
REM call %GITHUB_ACTION_RUN_PATH%\config.cmd --url https://github.com/GatewayDW --token %RUNNER_TOKEN%

@REM Step 4: Run this script to start the runner
call %GITHUB_ACTION_RUN_PATH%\run.cmd

REM Keep the window open to see the output (remove this line if running in background is preferred)
pause
