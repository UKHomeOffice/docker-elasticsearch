FROM fedora:30

ARG java_version=1.8.0.252.b09-0.fc30

RUN dnf upgrade -y -q; dnf clean all
RUN dnf install -y java-1.8.0-openjdk-headless-$java_version tar wget openssl apr hostname; dnf clean all
RUN groupadd -r -g 1000 elasticsearch && adduser -d /data -m -u 1000 -g 1000 elasticsearch

EXPOSE 9200 9300

RUN ls /usr/lib/jvm/

RUN sed '/grant {/a\
\\t java.lang.RuntimePermission "accessClassInPackage.sun.misc"; \n\
\t java.lang.RuntimePermission "accessDeclaredMembers"; \n\
\t java.lang.reflect.ReflectPermission "suppressAccessChecks"; \n\
  ' /usr/lib/jvm/java-1.8.0-openjdk-$java_version.x86_64/jre/lib/security/java.policy

ENV ES_VERSION 6.8.1
RUN wget -q https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ES_VERSION}.tar.gz -O - | tar -xzf -; mv elasticsearch-${ES_VERSION} /elasticsearch && mkdir -p /elasticsearch/config/scripts /elasticsearch/plugins
RUN echo "y" | /elasticsearch/bin/elasticsearch-plugin install repository-s3
RUN /elasticsearch/bin/elasticsearch-plugin install -b https://github.com/vvanholl/elasticsearch-prometheus-exporter/releases/download/6.8.1.0/prometheus-exporter-6.8.1.0.zip

COPY config/ /elasticsearch/config/

RUN chown -R elasticsearch:elasticsearch /data /elasticsearch

USER 1000

VOLUME /data
WORKDIR /elasticsearch

COPY run.sh /run.sh

CMD /run.sh
