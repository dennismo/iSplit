#!/bin/bash
# app="backend"
# docker build -t ${app} .
# docker run -d -p 5000:5000\
#   --name=${app} \
#   -v $PWD:/app ${app}

export APP_1_PORT=5000
export APP_2_PORT=5010
export APP_1_CTX=hello-py-1
export APP_2_CTX=hello-py-2
docker-compose up --build --force-recreate