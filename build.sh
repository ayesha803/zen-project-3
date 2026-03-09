#!/bin/bash

IMAGE=react-devops-app
DEV_REPO=ayeshadockerhub/react-dev-repo
PROD_REPO=ayeshadockerhub/react-prod-repo
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

docker build -t $IMAGE .

if [ "$BRANCH_NAME" == "dev" ]; then
    docker tag $IMAGE $DEV_REPO:latest
    docker push $DEV_REPO:latest
fi

if [ "$BRANCH_NAME" == "main" ]; then
    docker tag $IMAGE $PROD_REPO:latest
    docker push $PROD_REPO:latest
fi
