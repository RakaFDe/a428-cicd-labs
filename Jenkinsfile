pipeline {
    agent {
        docker {
            image 'node:16-buster-slim'
            args '-p 3001:3000'
            args '--privileged -v /var/run/docker.sock:/var/run/docker.sock'
            args '--user root'  // Jalankan sebagai root agar bisa install dependencies
        }
    }
    stages {
        stage('Install Docker CLI') {
                steps {
                    sh '''
                    apt update && apt install -y docker.io
                    '''
                }
            }
           stage('Check Port dan docker accessible') {
                steps {
                    script {
                        sh 'whoami'
                        sh 'groups'
                        sh 'docker --version || echo "Docker CLI tidak tersedia"'
                        sh 'docker ps || echo "Docker daemon tidak berjalan"'
                        sh "sleep 10"
                        def portInUse = sh(script: "ss -tulnp | grep ':3000 ' || echo 'unused'", returnStdout: true).trim()
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
            }
        }
        stage('Test') {
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
        stage('Deploy') { 
            steps {

                echo "🔄 Menghapus container lama jika ada..."
                sh 'docker stop react_app || true'
                sh 'docker rm react_app || true'
                sh 'pwd && ls -lah'
                echo "🚀 Menjalankan aplikasi dalam Docker container..."
                sh '''
                docker run -d --name react_app \
                -p 3001:3000 \
                -v $(pwd):/app \
                -w /app \
                node:16-buster-slim \
                sh -c "ls -lah && npm install && npm run build && npm start && tail -f /dev/null"
                '''
                sh 'docker ps -a'
                echo "⏳ Tunggu 60 detik agar aplikasi berjalan..."
                sh "sleep 60"
                sh 'docker ps -a'
                sh "sleep 10"
                input message: 'Sudah selesai menggunakan React App? (Klik "Proceed" untuk mengakhiri)' 

                echo "🛑 Menghentikan container..."
                sh '''
                    if [ "$(docker ps -q -f name=react_app)" ]; then
                    echo "🛑 Container react_app sedang berjalan, menghentikan..."
                        docker stop react_app
                    else
                        echo "⚠️ Container react_app tidak berjalan."
                    fi

                    if [ "$(docker ps -aq -f name=react_app)" ]; then
                        echo "🗑️ Menghapus container react_app..."
                        docker rm react_app
                    else
                        echo "✅ Tidak ada container react_app yang perlu dihapus."
                    fi
                    '''
            }
        }
    }
}
