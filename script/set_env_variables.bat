@echo off
@REM Set Environment Variables (Temporary, all variables will be gone after the bat program ends)
@REM Remove 1 `%` if you're running in interactive cmd line by line
for /f "delims=" %%a in ('type .env') do @set %%a