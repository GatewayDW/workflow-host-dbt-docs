@REM This script is for the situation when Docker is not used.
@REM Get the necessary ENV VAR from https://github.com/organizations/GatewayDW/settings/actions/runners/new
@REM Run this script using cmd terminal and in the project root directory

@REM Save current working directory
set CURRENT_DIR=%cd%

call .\script\99_set_env_base.bat
call .\script\conda\00_start_venv_miniconda_v1.bat

echo "Check if all necessary environment variables are set..."
set VARS=GITHUB_REPO_URL RUNNER_TOKEN ACTION_RUNNER_DOWNLOAD_URL GITHUB_ACTION_RUN_PATH
for %%V in (%VARS%) do (
  if not defined %%V (
    echo "%%V is not set or empty."
    exit /b 1
  )
)
echo "All necessary environment variables are set."

echo "Remove existing GitHub Action Runner folder..."
if exist %GITHUB_ACTION_RUN_PATH% (
    rmdir /s /q %GITHUB_ACTION_RUN_PATH%
)

echo "Downloading and Unzipping the latest GitHub Actions Self-Hosted Runner..."
mkdir %GITHUB_ACTION_RUN_PATH%
cd %GITHUB_ACTION_RUN_PATH%
curl -o action-runner-win-extract.zip -L %ACTION_RUNNER_DOWNLOAD_URL%
tar -xzf action-runner-win-extract.zip

echo "Cleaning up..."
del action-runner-win-extract.zip

echo "Start configuring the GitHub Actions Self-Hosted Runner..."
echo "Once the configuration is done, you can run the below scripts:"
echo "  To start the runner service, Execute 02_register_github_action_runner.bat"
echo "  To remove the runner, Execute 03_remove_github_action_runner.bat"
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

