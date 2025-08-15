## Download

We recommend configuring the runner under `\actions-runner`. This will help avoid issues related to service identity folder permissions and long path restrictions on Windows.

```bash
# Create a folder under the drive root
$ mkdir actions-runner; cd actions-runner

# Download the latest runner package
$ Invoke-WebRequest -Uri https://github.com/actions/runner/releases/download/v2.326.0/actions-runner-win-x64-2.326.0.zip -OutFile actions-runner-win-x64-2.326.0.zip

# Optional: Validate the hash
$ if((Get-FileHash -Path actions-runner-win-x64-2.326.0.zip -Algorithm SHA256).Hash.ToUpper() -ne '539d48815f8ed6ad09375052d5b578f919a32629b713d5a9a24419fe4dbd9e'.ToUpper()){ throw 'Computed checksum did not match' }

# Extract the installer
$ Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory("$PWD/actions-runner-win-x64-2.326.0.zip", "$PWD")
