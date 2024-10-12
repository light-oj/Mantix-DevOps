# Task 2: Scripting Automation

This task automates the installation of Chocolatey and the required software using Chocolatey. The script installs the following:

- Chocolatey (If not pre-installed)
- Git
- Node.js
- Google Chrome
- Docker Desktop


## Script Overview

The script `Install-Software.ps1` checks if Chocolatey is already installed on the Windows Server. If not, it procceds to install it.

The script then installs the required software using Chocolatey. It checks if the software is already installed, and if not, it proceeds with the installation.

### Script: Install-Software.ps1

```powershell
# Install-Software.ps1
# Ensure that Chocolatey is installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey is not installed. Installing Chocolatey..."
    
    Set-ExecutionPolicy Bypass -Scope Process -Force;
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
    
    Write-Host "Chocolatey installed successfully."
} else {
    Write-Host "Chocolatey is already installed."
}

# Define the list of software packages to install or update
$packages = @("git", "nodejs", "googlechrome", "docker-desktop")

# Function to check installation and update
function InstallOrUpdatePackage {
    param (
        [string]$packageName
    )
    
    # Check if the package is already installed
    $packageInfo = choco list --local-only | Where-Object { $_ -match $packageName }

    if ($packageInfo) {
        Write-Host "$packageName is already installed. Checking for updates..."
        # Update the package if it is installed
        choco upgrade $packageName -y
        Write-Host "$packageName has been updated."
    } else {
        Write-Host "$packageName is not installed. Installing now..."
        # Install the package if not installed
        choco install $packageName -y
        Write-Host "$packageName has been installed."
    }
}

# Iterate through the list of packages and install or update them
foreach ($package in $packages) {
    InstallOrUpdatePackage $package
}

Write-Host "Software installation and update process is complete."
```

## Usage Instructions

1. Open PowerShell as Administrator.
2. Navigate to the directory where `Install-Software.ps1` is located.
3. Run the script:

   ```powershell
   ./Install-Software.ps1
   ```

The script will install Chocolatey and check if the required software (Git, Node.js, Google Chrome, Docker Desktop) is installed. If any software is not found, it will automatically install it using Chocolatey.
