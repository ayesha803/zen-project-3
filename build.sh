#!/bin/bash

IMAGE_NAME=ecommerce-app-react
DEV_REPO=ayeshadockerhub/react-dev-repo
PROD_REPO=ayeshadockerhub/react-prod-repo

BRANCH=$(git rev-parse --abbrev-ref HEAD)

#Building docker image
echo "building docker image"

docker build -t $IMAGE_NAME .

echo "Build Completed...."


if [ $BRANCH = 'dev' ]; then
	docker tag $IMAGE_NAME $DEV_REPO:v1
	docker push  $DEV_REPO:v1

fi

if [ $BRANCH = 'main' ]; then
	docker tag $IMAGE_NAME $PROD_REPO:v1
	docker push  $PROD_REPO:v1

fi








