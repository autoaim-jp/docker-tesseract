#!/bin/bash

#CONTAINER_NAME=t4re
CONTAINER_NAME=t4-2204

docker run -dt --name $CONTAINER_NAME tesseract4-ubuntu2204
docker ps -f name=$CONTAINER_NAME
