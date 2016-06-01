FROM fedora:23

RUN dnf upgrade -y -q; dnf clean all
RUN dnf install -y -q java-headless tar wget openssl hostname; dnf clean all
RUN adduser -d /data -m elasticsearch

EXPOSE 9200 9300

ENV ES_VERSION 2.3.2
RUN wget -q https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${ES_VERSION}/elasticsearch-${ES_VERSION}.tar.gz -O - | tar -xzf -; mv elasticsearch-${ES_VERSION} /elasticsearch && mkdir -p /elasticsearch/config/scripts /elasticsearch/plugins
RUN /elasticsearch/bin/plugin install io.fabric8/elasticsearch-cloud-kubernetes/${ES_VERSION}
RUN /elasticsearch/bin/plugin install com.floragunn/search-guard-ssl/2.3.2.9

VOLUME /data
WORKDIR /elasticsearch

COPY config/ /elasticsearch/config/
COPY run.sh /run.sh

CMD /run.sh
