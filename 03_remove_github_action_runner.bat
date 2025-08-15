call .\script\99_set_env_base.bat
call .\script\conda\00_start_venv_miniconda_v1.bat

@REM Start the GitHub Actions Self-Hosted Runner
@REM If it is not success, go to https://github.com/organizations/GatewayDW/settings/actions/runners and Force remove the runner
cd %GITHUB_ACTION_RUN_PATH%
config.cmd remove --token %RUNNER_TOKEN%