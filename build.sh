#!/bin/bash

IMAGE_NAME=ecommerce-app-react

#build image

echo "building docker image"

docker build -t $IMAGE_NAME .

echo "Build completed ....."

