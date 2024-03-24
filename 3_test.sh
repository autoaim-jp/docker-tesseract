#!/bin/bash

# CONTAINER_NAME=t4re
CONTAINER_NAME=t4-2204
IMAGE_FILE_NAME=output.png

docker ps -f name=$CONTAINER_NAME
TASK_TMP_DIR=TASK_$$_$(date +"%N")

echo "====== TASK $TASK_TMP_DIR started ======"
# ready
docker exec -it $CONTAINER_NAME mkdir \-p ./$TASK_TMP_DIR/
docker cp ./$IMAGE_FILE_NAME $CONTAINER_NAME:/home/work/$TASK_TMP_DIR/

# ocr
docker exec -it $CONTAINER_NAME /bin/bash -c "mkdir -p ./$TASK_TMP_DIR/out/; cd ./$TASK_TMP_DIR/out/; tesseract ../$IMAGE_FILE_NAME phototest -l jpn --psm 1 --oem 3 txt pdf hocr"

# download result
mkdir -p ./ocr-files/output/$TASK_TMP_DIR/
docker cp $CONTAINER_NAME:/home/work/$TASK_TMP_DIR/out/ ./ocr-files/output/$TASK_TMP_DIR/
docker exec -it $CONTAINER_NAME rm \-r ./$TASK_TMP_DIR/
docker exec -it $CONTAINER_NAME ls
echo "====== Result files was copied to ./ocr-files/output/$TASK_TMP_DIR/ ======"

# open
xdg-open ./ocr-files/output/$TASK_TMP_DIR/out/phototest.txt
