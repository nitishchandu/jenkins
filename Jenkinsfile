pipeline {
    agent any 
    environment {
        registryCredential = '[dockerhub]'
        imageName = 'nitishchandu/external'
        dockerImage = ''
        }
    stages {
        stage('Run the tests') {
             agent {
                docker { 
                    image 'node:18-alpine'
                    args '-e HOME=/tmp -e NPM_CONFIG_PREFIX=/tmp/.npm'
                    reuseNode true
                }
            }
            steps {
                echo 'Retrieve source from github. run npm install and npm test' 
            }
        }
        stage('Building image') {
            steps{
                script {
                    git branch: 'my_specific_branch',
                        url: 'https://github.com/nitishchandu/deloitte_devops_trn_external.git'
                    sh 'ls -l'
                    echo 'build the image' 
                }
            }
            }
        stage('Push Image') {
            steps{
                script {
                    echo 'push the image to docker hub' 
                }
            }
        }     
         stage('deploy to k8s') {
             agent {
                docker { 
                    image 'google/cloud-sdk:latest'
                    args '-e HOME=/tmp'
                    reuseNode true
                        }
                    }
            steps {
                echo 'authenticating with k8s cluser'
                sh 'gcloud container clusters get-credentials cluster-1 --zone us-central1-c --project roidtc-june22-u111'
             }
        }     
        stage('Remove local docker image') {
            steps{
                sh "docker rmi $imageName:latest"
                sh "docker rmi $imageName:$BUILD_NUMBER"
            }
        }
    }
}