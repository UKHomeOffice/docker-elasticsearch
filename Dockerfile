FROM quay.io/ukhomeofficedigital/centos-base:v0.2.0

RUN yum upgrade -y -q; yum clean all
RUN yum install -y -q java-headless tar wget openssl apr; yum clean all
RUN adduser -d /data -m elasticsearch

EXPOSE 9200 9300

ENV ES_VERSION 2.2.1
RUN wget -q https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${ES_VERSION}/elasticsearch-${ES_VERSION}.tar.gz -O - | tar -xzf -; mv elasticsearch-${ES_VERSION} /elasticsearch && mkdir -p /elasticsearch/config/scripts /elasticsearch/plugins
RUN /elasticsearch/bin/plugin install io.fabric8/elasticsearch-cloud-kubernetes/${ES_VERSION}
RUN /elasticsearch/bin/plugin install com.floragunn/search-guard-ssl/2.2.1.7 && (cd /elasticsearch/plugins/search-guard-ssl/ && wget -q http://repo1.maven.org/maven2/io/netty/netty-tcnative/1.1.33.Fork13/netty-tcnative-1.1.33.Fork13-linux-x86_64-fedora.jar)

VOLUME /data
WORKDIR /elasticsearch

COPY config/ /elasticsearch/config/
COPY run.sh /run.sh

CMD /run.sh
