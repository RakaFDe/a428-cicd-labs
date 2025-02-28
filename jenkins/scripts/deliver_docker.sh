#!/usr/bin/env sh

echo "Building Docker Image..."
docker build -t react-app .

echo "Stopping and Removing Existing Container (if exists)..."
docker stop react-container || true
docker rm react-container || true

echo "Running React App in Docker Container..."
docker run -d -p 3000:3000 --name react-container react-app

echo "Aplikasi sekarang berjalan di http://localhost:3000"
