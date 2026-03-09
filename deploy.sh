#!/bin/bash

SERVER=35.170.75.177

ssh -o StrictHostKeyChecking=no ubuntu@$SERVER << EOF

cd devops-build
git pull

docker-compose pull
docker-compose up -d

EOF
