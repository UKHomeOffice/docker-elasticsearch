#!/bin/bash

export CLUSTER_NAME=${CLUSTER_NAME:=elasticsearch}
export NODE_NAME=${NODE_NAME:=${HOSTNAME}}
export NODE_INGEST=${NODE_INGEST:=true}
export PATH_DATA=${PATH_DATA:=/data}
export MEM_LOCK=${MEM_LOCK:=true}
export ELASTIC_SEARCH_HEAP_SIZE=${ELASTIC_SEARCH_HEAP_SIZE:=450m}
export ES_JAVA_OPTS="${ES_JAVA_OPTS} -Xms${ELASTIC_SEARCH_HEAP_SIZE} -Xmx${ELASTIC_SEARCH_HEAP_SIZE} -Dlog4j2.disable.jmx=true"
export INDEX_AUTO_EXPAND_REPLICAS=${INDEX_AUTO_EXPAND_REPLICAS:=false}
export INDEX_NUMBER_OF_SHARDS=${INDEX_NUMBER_OF_SHARDS:=5}
export INDEX_NUMBER_OF_REPLICAS=${INDEX_NUMBER_OF_REPLICAS:=1}
export INDEX_REFRESH_INTERVAL=${INDEX_REFRESH_INTERVAL:=1s}
export GATEWAY_EXPECTED_MASTER_NODES=${GATEWAY_EXPECTED_MASTER_NODES:=0}
export GATEWAY_EXPECTED_DATA_NODES=${GATEWAY_EXPECTED_DATA_NODES:=0}
export NODE_MASTER=${NODE_MASTER:=true}
export NODE_DATA=${NODE_DATA:=true}
export HTTP_ENABLE=${HTTP_ENABLE:=true}
export HTTP_BIND_HOST=${HTTP_BIND_HOST:=0.0.0.0}
export KUBERNETES_SERVICE=${KUBERNETES_SERVICE:=elasticsearch-master}
export KUBERNETES_NAMESPACE=${KUBERNETES_NAMESPACE:=default}
export DISCOVERY_ZEN_FD_PING_INTERVAL=${DISCOVERY_ZEN_FD_PING_INTERVAL:=1s}
export DISCOVERY_ZEN_FD_PING_TIMEOUT=${DISCOVERY_ZEN_FD_PING_TIMEOUT:=30s}
export DISCOVERY_ZEN_FD_PING_RETRIES=${DISCOVERY_ZEN_FD_PING_RETRIES:=3}
export DISCOVERY_ZEN_PUBLISH_TIMEOUT=${DISCOVERY_ZEN_PUBLISH_TIMEOUT:=30s}
export DISCOVERY_ZEN_UNICAST_HOST=${DISCOVERY_ZEN_UNICAST_HOST:=elasticsearch}
export DISCOVERY_ZEN_MINIMUM_MASTER_NODES=${DISCOVERY_ZEN_MINIMUM_MASTER_NODES:=1}
export THREAD_POOL_BULK_QUEUE_SIZE=${THREAD_POOL_BULK_QUEUE_SIZE:=50}
export INDEX_BUFFER_SIZE=${INDEX_BUFFER_SIZE:=10%}
export CLOUD_AWS_S3_ACCESS_KEY=${CLOUD_AWS_S3_ACCESS_KEY:=}
export CLOUD_AWS_S3_SECRET_KEY=${CLOUD_AWS_S3_SECRET_KEY:=}
export CLOUD_AWS_S3_ENDPOINT=${CLOUD_AWS_S3_ENDPOINT:=s3.eu-west-2.amazonaws.com}
export XPACK_SECURITY_ENABLE=${XPACK_SECURITY_ENABLE:=false}
export XPACK_SECURITY_AUDIT_ENABLE=${XPACK_SECURITY_AUDIT_ENABLE:=false}
export XPACK_SECURITY_AUDIT_INDEX_EVENTS_EXCLUDE=${XPACK_SECURITY_AUDIT_INDEX_EVENTS_EXCLUDE:=}
export XPACK_SECURITY_AUDIT_LOGFILE_EVENTS_EXCLUDE=${XPACK_SECURITY_AUDIT_LOGFILE_EVENTS_EXCLUDE:=}
export XPACK_SECURITY_AUDIT_OUTPUTS=${XPACK_SECURITY_AUDIT_OUTPUTS:=logfile}
export XPACK_SECURITY_TRANSPORT_SSL_ENABLE=${XPACK_SECURITY_TRANSPORT_SSL_ENABLE:=false}
export XPACK_SECURITY_HTTP_SSL_ENABLE=${XPACK_SECURITY_HTTP_SSL_ENABLE:=false}
export XPACK_SSL_KEY_PATH=${XPACK_SSL_KEY_PATH:=}
export XPACK_SSL_CERT_PATH=${XPACK_SSL_CERT_PATH:=}
export XPACK_SSL_CA_CERT_PATH=${XPACK_SSL_CA_CERT_PATH:=}
export XPACK_MONITORING_ENABLE=${XPACK_MONITORING_ENABLE:=false}
export XPACK_ML_ENABLE=${XPACK_ML_ENABLE:=false}
export XPACK_WATCHER_ENABLE=${XPACK_WATCHER_ENABLE:=false}
export XPACK_EMAIL_DEFAULTS_FROM=${XPACK_EMAIL_DEFAULTS_FROM:="test@localhost"}
export XPACK_EMAIL_SMTP_AUTH=${XPACK_EMAIL_SMTP_AUTH:=false}
export XPACK_EMAIL_SMTP_STARTTLS_ENABLE=${XPACK_EMAIL_SMTP_STARTTLS_ENABLE:=false}
export XPACK_EMAIL_SMTP_STARTTLS_REQUIRED=${XPACK_EMAIL_SMTP_STARTTLS_REQUIRED:=false}
export XPACK_EMAIL_SMTP_HOST=${XPACK_EMAIL_SMTP_HOST:=localhost}
export XPACK_EMAIL_SMTP_PORT=${XPACK_EMAIL_SMTP_PORT:=25}
export XPACK_EMAIL_SMTP_USER=${XPACK_EMAIL_SMTP_USER:=false}
export XPACK_EMAIL_SMTP_PASS=${XPACK_EMAIL_SMTP_PASS:=false}

export ENABLE_TRANSPORT_SSL=${ENABLE_TRANSPORT_SSL:=false}

/elasticsearch/bin/elasticsearch
