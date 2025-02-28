    pipeline {
        agent {
            docker {
                image 'node:16-buster-slim'
                args '-p 3001:3001'
                args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
            }
        }
        stages {
            stage('Install Docker CLI') {
                steps {
                    sh '''
                    apt update
                    apt install -y docker.io
                    '''
                }
            stage('Check Port dan docker accessible') {
                steps {
                    script {
                        sh 'whoami'
                        sh 'groups'
                        sh 'docker --version || echo "Docker CLI tidak tersedia"'
                        sh 'docker ps || echo "Docker daemon tidak berjalan"'
                        sh "sleep 20"
                        def portInUse = sh(script: "netstat -tulnp | grep ':3000 ' || echo 'unused'", returnStdout: true).trim()
                        if (portInUse != "unused") {
                            error "Port 3000 sudah digunakan! Harap pastikan tidak ada aplikasi lain yang berjalan di port ini."
                        } else {
                            echo "Port 3000 tersedia, melanjutkan build..."
                        }
                    }
                }
            }
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
                    sh 'docker run -d --name react_app -p 3001:3001 node:16-buster-slim sh -c "npm install && npm start"'

		    echo " tunggu"
		    sh "sleep 60"

                    input message: 'Sudah selesai menggunakan React App? (Klik "Proceed" untuk mengakhiri)' 
                    echo "Menghentikan container..."
                    sh 'docker stop react_app && docker rm react_app'
                }
            }
        }
    }