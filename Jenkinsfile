pipeline {
    agent {
        docker {
            image 'node:16-buster-slim'
            args '--user root'  // Jalankan sebagai root agar bisa install dependencies
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
        stage('Deploy') { 
            steps {
                echo "🔄 Menghapus container lama jika ada..."
                sh 'docker stop react_app || true'
                sh 'docker rm react_app || true'

                echo "🚀 Menjalankan aplikasi dalam Docker container..."
                sh '''
                docker run -d --name react_app \
                -p 3000:3000 \
                -v $(pwd):/app \
                -w /app \
                node:16-buster-slim \
                sh -c "npm install && npm run build && npm start"
                '''

                echo "⏳ Tunggu 60 detik agar aplikasi berjalan..."
                sh "sleep 60"

                input message: 'Sudah selesai menggunakan React App? (Klik "Proceed" untuk mengakhiri)' 

                echo "🛑 Menghentikan container..."
                sh 'docker stop react_app && docker rm react_app'
            }
        }
    }
}
