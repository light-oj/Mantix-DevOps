# Task 4: Jenkins Pipeline Configuration

This task sets up a Jenkins pipeline to automate the deployment of a web application to IIS. The pipeline consists of the following stages:
- Clone the repository
- Install required dependencies via Chocolatey
- Deploy the web app to IIS

## Jenkins Pipeline Script (Jenkinsfile)

```groovy
pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Clone the GitHub repository
                    git branch: 'master', url: 'https://github.com/startbootstrap/startbootstrap-freelancer.git'
                }
            }
        }

        stage('Install Dependencies via Chocolatey') {
            steps {
                script {
                    // Install required software using Chocolatey
                    powershell 'C:/Users/azureuser/Documents/Install-Software.ps1'
                }
            }
        }

        stage('Deploy to IIS') {
            steps {
                script {
                    // Execute the web app deployment script to IIS
                    powershell 'C:/Users/azureuser/Documents/DeployWebApp.ps1'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
        success {
            echo 'Build and deployment successful!'
        }
        failure {
            echo 'Build failed.'
        }
    }
}
```

## Pipeline Stages Breakdown

### 1. Clone Repository

The first stage of the pipeline clones the `startbootstrap-freelancer` GitHub repository. Ensure that the correct branch is specified (in this case, the `master` branch).

```groovy
stage('Clone Repository') {
    steps {
        script {
            git branch: 'master', url: 'https://github.com/startbootstrap/startbootstrap-freelancer.git'
        }
    }
}
```

### 2. Install Dependencies via Chocolatey

This stage installs necessary software, such as Git, Node.js, and other dependencies, using a pre-existing PowerShell script (`Install-Software.ps1`). The script automates software installation using Chocolatey.

```groovy
stage('Install Dependencies via Chocolatey') {
    steps {
        script {
            powershell 'C:/Users/azureuser/Documents/Install-Software.ps1'
        }
    }
}
```

### 3. Deploy to IIS

In this stage, the web application is deployed to IIS using another PowerShell script (`DeployWebApp.ps1`), which configures IIS, creates a new website, and binds it to the desired port.

```groovy
stage('Deploy to IIS') {
    steps {
        script {
            powershell 'C:/Users/azureuser/Documents/DeployWebApp.ps1'
        }
    }
}
```

### Post-Build Actions

After each pipeline execution, whether successful or failed, the workspace is cleaned up to ensure that subsequent builds are executed in a clean environment.

```groovy
post {
    always {
        echo 'Cleaning up workspace...'
        cleanWs()
    }
    success {
        echo 'Build and deployment successful!'
    }
    failure {
        echo 'Build failed.'
    }
}
```

## Setting Up Jenkins

### Step-by-Step Guide

1. **Install Jenkins**:
   - If Jenkins is not already installed, you can download and install it from [https://jenkins.io](https://jenkins.io).
      ![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/da7fea0397dba26155123e91f77d3cad35e50eca7fa2393d.png)

2. **Install Necessary Plugins**:
   - Ensure that you have the Git and PowerShell plugins installed in Jenkins.
      ![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/9c785cf144abbed6f100fe7f0eef319e6cb6e3f62e16b35e.png)  

3. **Create a New Pipeline Job**:
   - In Jenkins, create a new pipeline job.
   - Configure the job to pull the `Jenkinsfile` from the repository where your pipeline configuration is located.
    ![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/14aec7626acc0e1d9ac089d855e27a36f0fbb0e7af4a5221.png)

4. **Run the Pipeline**:
   - Once the pipeline is set up, you can trigger the build. It will automatically execute the stages and deploy the web application.
    ![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/15159c4642d141251a412bb11d0bdd0a7fab569c2dc48dea.png)

    ![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/efd360d6d1bed1e9ad68546be69771942d65623dfbb66239.png)

    ![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/aaf6f62a07afcc4f08109c5ebca92c67eb32ef258dd67a8b.png)


## Notes

- Ensure that your Jenkins agent has sufficient permissions to execute PowerShell scripts and install software using Chocolatey.
- The web app should be accessible via the IP address of the Windows Server running IIS on the specified port.
