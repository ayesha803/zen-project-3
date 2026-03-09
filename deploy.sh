#!/bin/bash

SERVER=35.170.75.177
REPO=https://github.com/ayesha803/zen-project-3.git
DIR=zen-project-3

ssh -o StrictHostKeyChecking=no ubuntu@$SERVER << EOF

if [ ! -d "$DIR" ]; then
    git clone $REPO
fi

cd $DIR
git pull

docker-compose pull
docker-compose up -d

EOF
