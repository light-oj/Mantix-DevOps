# DevOps Project: Jenkins CI/CD Pipeline, Automation, and Web App Deployment

This project demonstrates the setup and execution of a Jenkins pipeline that automates the deployment of a web application to IIS on a Windows Server environment. The project includes automated installation of required software using Chocolatey and PowerShell scripts. The project tasks are divided as follows:

## Prerequisites

Before you begin, ensure that you have the following:
- Windows Server (cloud-based setup, Azure recommended)
- Administrator access to the server
- Jenkins installed and running
- Git installed
- Docker installed and running
- IIS (Internet Information Services) installed

## Setup Guide

### Task 1: Environment Setup
1. Set up a Windows Server instance (Azure VM recommended).
2. Install the following software on the server:
   - Docker
   - Git
   - IIS
3. Documentation on how to set up the environment is available in `Task1_Environment_Setup.md`.

### Task 2: Scripting Automation
- The PowerShell script `Install-Software.ps1` installs necessary software (e.g., Docker, Git, Node.js, and Google Chrome) via Chocolatey.
  
#### How to Execute:
   1. Open PowerShell as Administrator.
   2. Run the script using:
      ```bash
      powershell "C:/path/to/Install-Software.ps1"
      ```
   3. Documentation is available in `Task2_Scripting_Automation.md`.

### Task 3: Configuration Management (Deploy to IIS)
- The PowerShell script `DeployWebApp.ps1` automates the deployment of a web application to IIS.

#### How to Execute:
   1. Ensure IIS is installed and running.
   2. Open PowerShell as Administrator.
   3. Run the script using:
      ```bash
      powershell "C:/path/to/DeployWebApp.ps1"
      ```
   4. Documentation is available in `Task3_Web_App_Deployment_to_IIS.md`.

### Task 4: Jenkins Pipeline Setup
- The Jenkins pipeline script `Jenkinsfile` automates the build and deployment process.

#### Pipeline Stages:
1. **Clone Repository**: Fetches the source code from the GitHub repository.
2. **Install Dependencies via Chocolatey**: Installs required dependencies using `Install-Software.ps1`.
3. **Deploy to IIS**: Executes the deployment script `DeployWebApp.ps1` to deploy the application to IIS.
4. Documentation is available in `Task4_Jenkin_Pipeline_Configuration.md`.

#### How to Execute:
1. Open Jenkins and create a new pipeline job.
2. Configure the job and copy the pipeline script in `Jenkinsfile` provided in this project.
3. Run the pipeline to automate the web app deployment process.

## File Structure
- `Task1_Environment_Setup.md`: Documentation for Windows Server setup.
- `Install-Software.ps1`: PowerShell script to install necessary software using Chocolatey.
- `Task2_Scripting_Automation.md`: Documentation for Scripting Automation
- `DeployWebApp.ps1`: PowerShell script to deploy the web app to IIS.
- `Task3_Web_App_Deployment_to_IIS.md`: Documentation for Configuration Management
- `Task4_JenkinsPipeline.md`: Explanation of the Jenkins pipeline stages.
- `Jenkinsfile`: Jenkins pipeline script for automation.
- `README.md`: This guide.

## Assumptions
- The server has access to the internet for downloading software.
- The web app source is hosted on a public GitHub repository.
- The pipeline is configured to deploy to a local IIS instance on the same server.

## Conclusion
This project demonstrates end-to-end automation for deploying a web application using Jenkins and PowerShell scripts in a Windows Server environment. Ensure that all software is correctly installed before running the pipeline to avoid errors during execution.
