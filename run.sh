#!/bin/bash

export CLUSTER_NAME=${CLUSTER_NAME:=elasticsearch}
export NODE_NAME=${NODE_NAME:=${HOSTNAME}}
export PATH_DATA=${PATH_DATA:=/data}
export ES_HEAP_SIZE=${ES_HEAP_SIZE:=450m}
export INDEX_AUTO_EXPAND_REPLICAS=${INDEX_AUTO_EXPAND_REPLICAS:=false}
export NODE_MASTER=${NODE_MASTER:=true}
export NODE_DATA=${NODE_DATA:=true}
export HTTP_ENABLE=${HTTP_ENABLE:=true}
export KUBERNETES_SERVICE=${KUBERNETES_SERVICE:=elasticsearch-master}
export KUBERNETES_NAMESPACE=${KUBERNETES_NAMESPACE:=default}

su elasticsearch -c 'exec /elasticsearch/bin/elasticsearch'
