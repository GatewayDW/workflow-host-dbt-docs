echo Setting Environment Variables temporarily (all variables will be gone after the bat program ends)
@REM Remove 1 `%` if you're running in interactive cmd line by line (not encrypted .env)
for /f "delims=" %%a in  ('type .env ^| findstr /V /B "#"') do @set %%a