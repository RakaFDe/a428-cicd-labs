    pipeline {
        agent {
            docker {
                image 'node:16-buster-slim'
                args '-p 3001:3000'
            }
        }
        stages {
            stage('Build') {
                steps {
                    sh 'npm install'
                }
            }
            stage('Test') {
                steps {
                    sh './jenkins/scripts/test.sh'
                    
                }
            }
            stage('manual approval'){
                steps{
                    input message: 'Lanjutkan ke tahap Deploy? (Klik "Proceed" untuk mengakhiri)' 
                }                
            }
            stage('Deploy') { 
                steps {
                    sh './jenkins/scripts/deliver.sh'
                    sh 'sleep 60' 
                    input message: 'Sudah selesai menggunakan React App? (Klik "Proceed" untuk mengakhiri)' 
                    echo "stage deploy"
                    sh './jenkins/scripts/kill.sh' 
                }
            }
        }
    }