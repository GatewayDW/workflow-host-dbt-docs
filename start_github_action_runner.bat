@REM This script is for the situation when Docker is not used.
@REM Run this script using cmd terminal and in the project root directory

call .\script\99_set_env_base.bat
call .\script\conda\00_start_venv_miniconda_v1.bat

@REM Start the GitHub Actions Self-Hosted Runner
cd %GITHUB_ACTION_RUN_PATH%
@REM call %GITHUB_ACTION_RUN_PATH%\run.cmd --token %RUNNER_TOKEN%

REM Use PowerShell for the setup:
REM Follow the steps in https://github.com/organizations/GatewayDW/settings/actions/runners/new?arch=x64&os=win
REM And configure the runner
call %GITHUB_ACTION_RUN_PATH%\run.cmd

REM Keep the window open to see the output (remove this line if running in background is preferred)
pause
