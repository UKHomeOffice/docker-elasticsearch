FROM fedora:30

RUN dnf upgrade -y -q; dnf clean all
RUN dnf install -y -q java-headless tar wget openssl apr hostname; dnf clean all
RUN groupadd -r -g 1000 elasticsearch && adduser -d /data -m -u 1000 -g 1000 elasticsearch

EXPOSE 9200 9300

ENV ES_VERSION 6.8.1
RUN wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ES_VERSION}.tar.gz -O - | tar -xzf -; mv elasticsearch-${ES_VERSION} /elasticsearch && mkdir -p /elasticsearch/config/scripts /elasticsearch/plugins
RUN echo "y" | /elasticsearch/bin/elasticsearch-plugin install repository-s3

COPY config/ /elasticsearch/config/

RUN chown -R elasticsearch:elasticsearch /data /elasticsearch

USER 1000

VOLUME /data
WORKDIR /elasticsearch

COPY run.sh /run.sh

CMD /run.sh
