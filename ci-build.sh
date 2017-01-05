#!/usr/bin/env bash

set -e

# Cope with local builds with docker machine...
if [ "${DOCKER_MACHINE_NAME}" == "" ]; then
    DOCKER_HOST_NAME=localhost
    SUDO_CMD=sudo
    # On travis... need to do this for it to work!
    ${SUDO_CMD} service docker restart ; sleep 10
else
    DOCKER_HOST_NAME=$(docker-machine ip ${DOCKER_MACHINE_NAME})
    SUDO_CMD=""
fi

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
        ${SUDO_CMD}  docker stop es_thing
    fi
    ${SUDO_CMD}  docker rm es_thing
fi

docker build -t es .
${SUDO_CMD}  docker run --ulimit=nofile=65536:65536 --ulimit=memlock=-1:-1 --name es_thing -d -p 9200:9200 -p 9300:9300 -e NODE_LOCAL=true es
get http://${DOCKER_HOST_NAME}:9200/
docker logs es_thing
get http://${DOCKER_HOST_NAME}:9200/_cluster/health?pretty
