## Task 1: Environment Setup Documentation

#### Introduction

For this task, you may deploy a Windows Server either locally using tools like VirtualBox or in a cloud-based environment such as Azure, AWS, etc. I will be using the cloud-based environment with Microsoft Azure. This document outlines the steps taken to set up a Windows Server environment on Azure, including the installation of required software such as Docker and Git.

##### Prerequisites
- An Azure account.
- Permissions to create and manage resources in Azure.


##### Steps to Set Up Windows Server on Azure
- Log in to the Azure Portal.
- Navigate to the "Virtual Machines" section or use the global search bar to locate the "Virtual Machines" service.
![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/789b5dcd3246d7d583c1a1ceaa1c5aff7529c782d40152e7.png)

- Click on the "Create" button and select Azure Virtual Machine from the dropdown.
![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/3d9c4f974471ae2d29081640a41cf9acd6a6a927dc5c714a.png)

Fill in the following details on the next page:
  + Subscription: Choose the appropriate subscription.
  + Resource Group: Create a new resource group or select an existing one.
  + VM Name: Provide a name for your VM (e.g., MantixVM).
  + Region: Select a region close to your user base.
  + Availability Options: Select the desired option (e.g., no infrastructure redundancy required).
  + Image: Choose Windows Server 2022 Datacenter.
  + Size: Choose the appropriate virtual machine size based on your performance needs. For this assessment, an E-series VM with a spot instance will be used to save costs.
  + Administrator Account: Enter a username and password for the admin account.
![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/3459ddbee2290150a8638f9216da32451968d02849036733.png)

Configure other necessary settings like disks, networking, management, and tags. Once all settings are configured, click "Review + Create" to review the setup and then click the "Create" button to deploy the VM. Wait for the deployment to complete, then navigate to the VM’s overview page.

###### Installing Required Software

###### Connect to the VM
After VM deployment, navigate to the resource and select "Connect".
![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/a2d86b4aec7feac82aa0357eecea920a51abddd086139258.png)

Download the RDP file and run it to establish a connection.
![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/2e30ed5dfbab03d98b0245a3296fc1e1915d1cfe074cdd5f.png)

Use the username and password set during configuration to connect to the VM.
or
Use Remote Desktop Protocol (RDP) on your local computer to connect to the VM.
Open RDP and log in with your admin credentials.

![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/ea1f49517d21098a65ac3621f66e90591fde88588f4461d0.png)

# Install Docker on Windows Server:
 1. Open PowerShell as Administrator & Download Docker setup script directly: 
```powershell
Invoke-WebRequest -UseBasicParsing -Uri https://download.docker.com/win/static/stable/x86_64/docker-20.10.8.zip -OutFile docker.zip 
```

Extract Docker binaries: 
```powershell
Expand-Archive -Path docker.zip -DestinationPath $Env:ProgramFiles -Force 
```

Add Docker to the system path: 
```powershell
$env:Path += ";$Env:ProgramFiles\Docker" 
[Environment]::SetEnvironmentVariable("Path", $env:Path, [EnvironmentVariableTarget]::Machine) 
```

Verify Docker installation: 

```powershell
docker --version
```

![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/1f2fc254620ba16a2db3597ee8484cf837c0de5cc889b7a0.png)

After verifying the Docker version and confirming 

You can run *dockerd* to manually start the docker service 
![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/bacdbd65ab02cff89424989baa35c404645fa856d43ee8c2.png)

Then run *docker run hello-world* to test that docker is able to pull images as required.
![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/89bddcd70cc61238d9ec969f173bb255364236f9479a540d.png)

# Install Git:
Next, we will proceed to install git using the commands below in PowerShell admin. 

```powershell
Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.1/Git-2.42.0-64-bit.exe" -OutFile "$env:TEMP\git-installer.exe" 
Start-Process "$env:TEMP\git-installer.exe" -ArgumentList "/VERYSILENT" -Wait
```
![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/eb9f6b3d85fd783b7ba6e2f7290498c76f98e68dc536e2d5.png)

Manually add git to path 
![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/c90b87ece721708731689847a7997337eaeefa125c0f2cb8.png)

Verify installation by running:

   ```powershell
   git --version
   ```

# Install IIS (Web Server):

1. Open PowerShell and run the following to install IIS:

   ```powershell
   Install-WindowsFeature -name Web-Server -IncludeManagementTools
   ```
![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/942a68c0525e247519ffa9b4383513eddfdb8606a76ce819.png)

2. Verify that IIS is running by opening a browser in the VM and navigating to `http://localhost`.
![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/9ac1d22f1bae58b8f5699da95a2cd50245328bc9c155ebe7.png)
