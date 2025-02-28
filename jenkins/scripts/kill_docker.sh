#!/usr/bin/env sh

echo "Stopping and Removing React App Container..."
docker stop react-container || true
docker rm react-container || true

echo "Container stopped and removed."
