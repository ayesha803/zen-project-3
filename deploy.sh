#!/bin/bash

SERVER=35.170.75.177
REPO=https://github.com/sriram-R-krishnan/devops-build.git
DIR=devops-build

ssh -o StrictHostKeyChecking=no ubuntu@$SERVER << EOF

if [ ! -d "$DIR" ]; then
    git clone $REPO
fi

cd $DIR
git pull

docker-compose pull
docker-compose up -d

EOF
