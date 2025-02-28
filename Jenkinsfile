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
                    sh 'npm test'
                }
            }
            stage('Deploy') { 
                steps {
                    echo "check docker"
                    sh "docker --version"
                    sh "npm start &"
		            echo " tunggu"
		            sh "sleep 60"

		           

                    input message: 'Sudah selesai menggunakan React App? (Klik "Proceed" untuk mengakhiri)' 
                    echo "Menghentikan container..."
                    
                }
            }
        }
    }