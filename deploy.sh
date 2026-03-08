#!/bin/bash

CONTAINER_NAME=react-container
IMAGE_NAME=ecommerce-app-react

docker rm -f $CONTAINER_NAME || true

docker run -d -p 3000:80 --name $CONTAINER_NAME $IMAGE_NAME


