#!/bin/bash

set -e

IMAGE_NAME="app-image"
TAG="latest"

echo "Starting Docker build..."

docker build -t ${IMAGE_NAME}:${TAG} .

echo "Docker image built successfully: ${IMAGE_NAME}:${TAG}"
