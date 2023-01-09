@REM Conda environement
@REM Use `conda env create -f <environment.yml>` to create the environment
@REM Use `conda env create -f <environment.yml> --prefix <path>` to create the environment in a specified path
@REM Use `conda env export --no-builds > <environment.yml>` to export the environment
set venv_name=data-eng-310

@REM Current Project Directory
set app_dir=workflow-host-dbt-docs

@REM dbt project directory
set dbt_app_dir=etl\ghworkflow

@REM Determine Local or remote environment
echo "ComputerName == %ComputerName%"
if %ComputerName% == HOBDANGAN (
    @REM For local development
    echo "ComputerName == HOBDANGAN"
    set venv_root_dir="C:\Users\alan ngan\Anaconda3"
    set "script_dir=C:\Users\alan ngan\dev\%app_dir%\script"
    set "dbt_dir=C:\Users\alan ngan\dev\%app_dir%\%dbt_app_dir%"
    set "log_dir=C:\Users\alan ngan\dev\%app_dir%\log"
) else (
    @REM For local development
    echo "ComputerName <> GW6"
    set venv_root_dir="C:\Users\%USERNAME%\Anaconda3"
    set "script_dir=C:\Users\%USERNAME%\dev\%app_dir%\script"
    set "dbt_dir=C:\Users\%USERNAME%\dev\%app_dir%\%dbt_app_dir%"
    set "log_dir=C:\Users\%USERNAME%\dev\%app_dir%\log"
)

for %%G IN (
    "GW6"
    "GW6-DEV"
) DO (
    if /I "%ComputerName%"=="%%~G" (
        set venv_root_dir="F:\Anaconda3"
        @REM set "script_dir=F:\%app_dir%\script"
        @REM set "dbt_dir=F:\%app_dir%\etl\%dbt_app_dir%"
        @REM set "log_dir=F:\%app_dir%\log"
        set "script_dir=%~dp0%app_dir%\script"
        set "dbt_dir=%~dp0%app_dir%\%dbt_app_dir%"
        set "log_dir=%~dp0%app_dir%\log"
    )
)

echo venv_root_dir = %venv_root_dir%
echo venv_name = %venv_name%
echo app_dir = %app_dir%
echo script_dir = %script_dir%
echo dbt_dir = %dbt_dir%
echo log_dir = %log_dir%