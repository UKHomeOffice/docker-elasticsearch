FROM quay.io/ukhomeofficedigital/centos-base:v0.2.0

RUN yum upgrade -y -q; yum clean all
RUN yum install -y -q java-headless tar wget; yum clean all
RUN adduser -d /data -m elasticsearch

EXPOSE 9200 9300

ENV ES_VERSION 2.2.0
RUN wget -q https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${ES_VERSION}/elasticsearch-${ES_VERSION}.tar.gz -O - | tar -xzf -; mv elasticsearch-${ES_VERSION} /elasticsearch && mkdir -p /elasticsearch/config/scripts /elasticsearch/plugins && /elasticsearch/bin/plugin install io.fabric8/elasticsearch-cloud-kubernetes/${ES_VERSION}

VOLUME /data
WORKDIR /elasticsearch

COPY config/ /elasticsearch/config/
COPY run.sh /run.sh

CMD /run.sh
