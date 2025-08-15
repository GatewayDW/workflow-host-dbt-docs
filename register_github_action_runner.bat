@REM This script is for the situation when Docker is not used.
@REM Get the necessary ENV VAR from https://github.com/organizations/GatewayDW/settings/actions/runners/new
@REM Run this script using cmd terminal and in the project root directory

@REM Save current working directory
set CURRENT_DIR=%cd%

call .\script\99_set_env_base.bat
call .\script\conda\00_start_venv_miniconda_v1.bat

@REM Remove existing runner
if exist %GITHUB_ACTION_RUN_PATH% (
    rmdir /s /q %GITHUB_ACTION_RUN_PATH%
)

@REM Download and Unzip the latest GitHub Actions Self-Hosted Runner
mkdir %GITHUB_ACTION_RUN_PATH%
cd %GITHUB_ACTION_RUN_PATH%
curl -o action-runner-win-extract.zip -L %ACTION_RUNNER_DOWNLOAD_URL%
tar -xzf action-runner-win-extract.zip

@REM Remove the zip file
del action-runner-win-extract.zip

@REM Start the GitHub Actions Self-Hosted Runner
@REM Be aware that the questions inside config.cmd is changed
@REM Use `config.cmd --url %GITHUB_REPO_URL% --token %RUNNER_TOKEN%` if you don't want input redirection

@REM The answers are provided in the answers_runner_setup.txt file
@REM Question Sequence:
@REM   Enter the name of the runner group to add this runner to: [press Enter for Default] self-hosted
@REM   Enter the name of runner: [press Enter for <MACHINE NAME>] <ENTER>
@REM   Enter any additional labels (ex. label-1,label-2): [press Enter to skip] .ca
@REM   Enter name of work folder: [press Enter for _work] <ENTER>
@REM   Would you like to run this runner as a service? (Y/N) [press Enter for N] n
config.cmd --url %GITHUB_REPO_URL% --token %RUNNER_TOKEN% < %CURRENT_DIR%\answers_runner_setup.txt
