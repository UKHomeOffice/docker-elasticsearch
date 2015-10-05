#!/usr/bin/env bash

set -e

mkdir -p /etc/yum.repos.d
cat > /etc/yum.repos.d/elasticsearch.repo <<- EOF_REPO
[elasticsearch-${ELASTICSEARCH_MAJOR}]
name=Elasticsearch repository for ${ELASTICSEARCH_MAJOR}.x packages
baseurl=http://packages.elastic.co/elasticsearch/${ELASTICSEARCH_MAJOR}/centos
gpgcheck=1
gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1
EOF_REPO

rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch

yum install -y elasticsearch
yum clean all
