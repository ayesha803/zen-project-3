#!/bin/bash

set -e

echo "Stopping existing containers..."
docker-compose down

echo "Logging into Docker Hub..."
echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

echo "Pulling latest image from Docker Hub..."
docker-compose pull

echo "Starting containers with docker-compose..."
docker-compose up -d

echo "Deployment completed successfully."
