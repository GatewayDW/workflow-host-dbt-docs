Get-ChildItem Env:

$output_dir = "etl/ghworkflow"
$output_path = "$output_dir/profiles.yml"

mkdir $output_dir -Force

$content = echo "
test:
target: dev
outputs:
  dev:
    type: sqlserver
    driver: 'ODBC Driver 17 for SQL Server' # (The ODBC Driver installed on your system)
    server: gw6-dev.gateway.net
    database: TEST
    port: 1433
    schema: dbo
    user: <USER>
    password: <PASSWORD>
    trust_cert: true
"
# $content = echo "$env:SECRETS_DBT_PROFILE"

Out-File -FilePath $output_path -InputObject $content -Encoding utf8

# Convert to UTF-8 No BOM
$MyFile = Get-Content $output_path
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines($output_path, $MyFile, $Utf8NoBomEncoding)