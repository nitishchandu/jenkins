pipeline {
    agent any 
    environment {
        registryCredential = 'dockerhub'
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
                script {
                    git branch: 'main',
                        url: 'https://github.com/nitishchandu/deloitte_devops_trn_external.git'
                    sh 'npm install'
                    sh 'npm test'
                }
            }
        }
        stage('Building image') {
            steps{
                script {
                    git branch: 'main',
                        url: 'https://github.com/nitishchandu/deloitte_devops_trn_external.git'
                    sh 'ls -l'
                    echo 'build the image' 
                    sh "docker build -t ${imageName}:${env.BUILD_ID} ."
                }
            }
            }
        stage('Push Image') {
            steps{
                script {
                    echo 'push the image to docker hub' 
                    docker.withRegistry( '', registryCredential ) {
                        sh "docker push ${imageName}:${env.BUILD_ID}"
                    }
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
                sh 'gcloud container clusters get-credentials gcp-k8s-tf-cluster --zone us-central1-c --project poised-cortex-357007'
                sh "kubectl set image deployment/events-external-deployment events-external=${imageName}:${env.BUILD_ID} --namespace=events"
             }
        }     
        stage('Remove local docker image') {
            steps{
                sh "docker rmi $imageName:$BUILD_NUMBER"
            }
        }
    }
}
