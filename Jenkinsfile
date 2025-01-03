pipeline {
    
    agent any
    environment {
        KUBECONFIG = "C:/Users/saura/.kube/config"
    }
    
    stages {
        
        stage('Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/SaurabhP1/Jenkins-Docker-KubernetesMini-NodeApp.git']])
            }
        }
        
        stage('Build and Push'){
            environment{
                DOCKER_CREDS = credentials('dockerhub_jenkins')
            }
            steps{
                bat '''
                docker build -t saurabhh1/myrepo:node-%BUILD_NUMBER% .
                echo %DOCKER_CREDS_PSW%| docker login -u %DOCKER_CREDS_USR% --password-stdin
                docker push saurabhh1/myrepo:node-%BUILD_NUMBER%
                docker rmi saurabhh1/myrepo:node-%BUILD_NUMBER%
                docker logout
                '''
            }
        }
        
        stage('Update deployment manifest'){
            
            steps{
                withCredentials([string(credentialsId: 'github_api_token', variable: 'GITHUB_TOKEN')]){
                powershell '''
                (Get-Content .\\kubernetes\\deployment.yaml) -replace 'saurabhh1/myrepo.*', "saurabhh1/myrepo:node-$env:BUILD_NUMBER" | Set-Content .\\kubernetes\\deployment.yaml
                type .\\kubernetes\\deployment.yaml
                
                git config user.email saurabhp.dev@gmail.com
                git config user.name SaurabhP1
                git add .
                git commit -m "Updated by Jenkins Job BuildNumber $env:BUILD_NUMBER"
                git push https://$env:GITHUB_TOKEN@github.com/SaurabhP1/Jenkins-Docker-KubernetesMini-NodeApp.git HEAD:master
                '''
                }
                
            }
        }
        
        stage('Deploy'){
            steps{
                bat '''
                kubectl apply -f kubernetes/deployment.yaml
                kubectl get pods
                '''
            }
        }
    }
}
