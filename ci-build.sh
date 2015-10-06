#!/usr/bin/env bash

set -e

function get() {

    url=$1
    max_retries=10
    retries=0
    while true ; do
        if ! wget -O- $url ; then
            retries=$((retries + 1))
            if [ $retries -eq $max_retries ]; then
                return 1
            else
                echo "Retrying, $retries out of $max_retries..."
                sleep 5
            fi
        else
            return 0
        fi
    done
    echo
    return 1
}

if docker ps -a | grep es_thing ; then
    if docker ps | grep es_thing ; then
        sudo docker stop es_thing
    fi
    sudo docker rm es_thing
fi

docker build -t es .

# Cope with local builds with docker machine...
if [ "${DOCKER_MACHINE_NAME}" == "" ]; then
    DOCKER_HOST_NAME=localhost
    # On travis... need to do this for it to work!
    sudo service docker restart ; sleep 10
else
    DOCKER_HOST_NAME=$(docker-machine ip ${DOCKER_MACHINE_NAME})
fi

sudo docker run --name es_thing -d -p 9200:9200 -p 9300:9300  es

get http://${DOCKER_HOST_NAME}:9200/

docker logs es_thing

get http://${DOCKER_HOST_NAME}:9200/_cluster/health?pretty

sudo docker stop es_thing
sudo docker rm es_thing