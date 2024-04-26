@echo off
setlocal EnableDelayedExpansion

:: Total time taken: 65 seconds
:: Execution Datetime: 2024-02-21 18:36:09

:: If it fails because of SSLError:
:: `SSLError(SSLCertVerificationError(1, '[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: unable to get local issuer certificate (_ssl.c:1006)'))'`
:: Try running the following in (base) conda venv first
:: pip install --no-cache --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org pip-system-certs

:: Get current date and time in YYYY-MM-DD HH:MM:SS format
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set datetime=%%a
set datetime=%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2% %datetime:~8,2%:%datetime:~10,2%:%datetime:~12,2%

:: Correctly handle leading zeros in time calculation
:: Get start time in hundredths of a second, ensuring no leading zeros cause issues
for /f "tokens=1-4 delims=:.," %%a in ("%time: =0%") do (
    set /a "start=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610000"
)

echo Starting the environment creation process...
:: Create the conda environment and automatically approve prompts
call script\conda\00_start_base_venv_miniconda_v1.bat
call conda create --name %MINICONDA_VENV% python=%MINICONDA_PYTHON_VERSION% --yes

:: Resolve SSL certificate verification error
call pip config set global.trusted-host "pypi.org files.pythonhosted.org pypi.python.org repo.anaconda.com"

:: Use `--user` to resolve error 'defaulting to user installation because normal site-packages is not writeable'
@REM call pip install --user --no-cache --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org pip-system-certs
call pip install --user pip-system-certs

:: List all conda environments
echo Listing all Conda environments:
call conda env list


:: Check the status and report
if %ERRORLEVEL% equ 0 (
    echo.
    echo Status: SUCCESS
) else (
    echo.
    echo Status: FAILED
)

:: Get end time in hundredths of a second, ensuring no leading zeros cause issues
for /f "tokens=1-4 delims=:.," %%a in ("%time: =0%") do (
    set /a "end=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610000"
)

:: Calculate the duration
set /a "duration=(end-start)/100"

echo Start time: %start%0
echo End time: %end%0
echo Total time taken: %duration% seconds

:: Format the current date and time
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (
    set curDate=%%c-%%a-%%b
)
for /f "tokens=1-3 delims=:." %%a in ("%time%") do (
    set "curTime=%%a:%%b:%%c"
    if %%a LSS 10 (set "curTime=0%%a:%%b:%%c")
)
echo Execution Datetime: %curDate% %curTime%

endlocal