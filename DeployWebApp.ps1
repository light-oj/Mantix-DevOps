# Set variables
$siteName = "Freelancerupdate"
$sitePath = "C:\inetpub\wwwroot\dist"
$repoPath = "C:\ProgramData\Jenkins\.jenkins\workspace\WebAppDeployment"  # Jenkins workspace where the repo will be cloned
$port = 8050
$hostHeader = ""

# Ensure IIS is installed
if (!(Get-WindowsFeature -Name Web-Server).Installed) {
    Install-WindowsFeature -Name Web-Server -IncludeManagementTools
}

# Create the directory if it doesn't exist
if (-Not (Test-Path $sitePath)) {
    New-Item -Path $sitePath -ItemType Directory
}

# Copy the cloned repository files to the IIS directory
Copy-Item -Path "$repoPath\*" -Destination $sitePath -Recurse -Force

# Check if the site already exists
if (-not (Get-Website -Name $siteName -ErrorAction SilentlyContinue)) {
    New-Website -Name $siteName -PhysicalPath $sitePath -Port $port -HostHeader $hostHeader
} else {
    # If the site exists, restart it to apply any changes
    Restart-WebAppPool -Name "$siteName"
    Write-Host "Website $siteName restarted and running on port 8050."
}

Write-Host "Deployment complete. Website is running at http://localhost:8050/"
