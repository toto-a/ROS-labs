#!/bin/bash

if [[ -z $1 ]]; then
    echo "No parameter passed"
    exit 1
else 


    xhost +local:docker
    echo "Docker Image: $1 passed"

    docker run  --rm --gpus=all -it \
        -e DISPLAY=$DISPLAY \
        --env="QT_X11_NO_MITSHM=1" \
        --env="LIBGL_ALWAYS_SOFTWARE=1" \ 
        --restart=always \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        "$1" 
    
  

fi
