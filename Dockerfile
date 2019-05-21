FROM fedora:25

RUN dnf upgrade -y -q; dnf clean all
RUN dnf install -y -q java-headless tar wget openssl apr hostname; dnf clean all
RUN groupadd -r -g 1000 elasticsearch && adduser -d /data -m -u 1000 -g 1000 elasticsearch

EXPOSE 9200 9300

ENV ES_VERSION 5.6.16
RUN wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ES_VERSION}.tar.gz -O - | tar -xzf -; mv elasticsearch-${ES_VERSION} /elasticsearch && mkdir -p /elasticsearch/config/scripts /elasticsearch/plugins
RUN /elasticsearch/bin/elasticsearch-plugin install com.floragunn:search-guard-ssl:5.6.16-23 && (cd /elasticsearch/plugins/search-guard-ssl/ && wget -q http://repo1.maven.org/maven2/io/netty/netty-tcnative/1.1.33.Fork24/netty-tcnative-1.1.33.Fork24-linux-x86_64-fedora.jar)
RUN /elasticsearch/bin/elasticsearch-plugin install x-pack && \
    chmod 0755 /elasticsearch/config/x-pack && \
    chmod 0644 /elasticsearch/config/x-pack/*
RUN /elasticsearch/bin/elasticsearch-plugin install repository-s3

COPY config/ /elasticsearch/config/

RUN chown -R elasticsearch:elasticsearch /data /elasticsearch

USER 1000

VOLUME /data
WORKDIR /elasticsearch

COPY run.sh /run.sh

CMD /run.sh
