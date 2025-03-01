pipeline {
    agent any
    environment {
        IMAGE_NAME = "react-app"
        CONTAINER_NAME = "react-container"
        DOCKER_REGISTRY = "rakafd/react-app:latest"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch:'react-app', url: 'https://github.com/RakaFDe/a428-cicd-labs.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    sh 'docker build -t $IMAGE_NAME .'
                }
            }
        }

        stage('Test') {
            steps {
                sh './jenkins/scripts/test_docker.sh'
            }
        }

        stage('Deploy') {
            steps {
                sh './jenkins/scripts/deliver_docker.sh'
                input message: 'Sudah selesai menggunakan React App? (Klik "Proceed" untuk mengakhiri)'
                sh './jenkins/scripts/kill_docker.sh'
            }
        }
    }
}
