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
		    echo "Menjalankan aplikasi dalam Docker container..."
                    sh 'docker run -d --name react_app -p 3000:3000 node:16-buster-slim sh -c "npm install && npm start"'

		    echo " tunggu"
		    sh "sleep 60"

                    input message: 'Sudah selesai menggunakan React App? (Klik "Proceed" untuk mengakhiri)' 
                    echo "Menghentikan container..."
                    sh 'docker stop react_app && docker rm react_app'
                }
            }
        }
    }