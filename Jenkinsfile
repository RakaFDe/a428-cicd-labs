pipeline {
    agent {
        docker {
            image 'node:16-buster-slim'
            args '-p 3000:3000'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }
        stage('Test') {
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
        stage('Deploy') { 
            steps {
                script {
                    echo "Menjalankan aplikasi dalam Docker container (Production Mode)..."
                    sh 'docker run -d --name react_app -p 3000:3000 -v $(pwd)/build:/usr/share/nginx/html nginx:alpine'

                    echo "Menunggu 1 menit sebelum melanjutkan..."
                    sh 'sleep 60'
                    
                    //input message: 'Sudah selesai menggunakan React App? (Klik "Proceed" untuk mengakhiri)' 

                    echo "Menghentikan container..."
                    sh 'docker stop react_app && docker rm react_app'
                }
            }
        }
    }
}
