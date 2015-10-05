FROM quay.io/ukhomeofficedigital/openjdk8-jre:v0.1.0

ENV ELASTICSEARCH_MAJOR 1.7
ENV ELASTICSEARCH_VERSION 1.7.2

ADD ./install_from_repo.sh /tmp/

RUN /tmp/install_from_repo.sh

ENV ES_INSTALL=/usr/share/elasticsearch
ENV PATH ${ES_INSTALL}/bin:$PATH

RUN set -ex \
	&& for path in \
		/data \
		${ES_INSTALL}/logs \
		${ES_INSTALL}/config \
		${ES_INSTALL}/config/scripts \
	; do \
		mkdir -p "$path"; \
		chown -R elasticsearch:elasticsearch "$path"; \
	done

# Override elasticsearch.yml config, otherwise plug-in install will fail
ADD do_not_use.yml ${ES_INSTALL}/config/elasticsearch.yml

# Install Elasticsearch plug-ins
RUN ${ES_INSTALL}/bin/plugin -i io.fabric8/elasticsearch-cloud-kubernetes/1.3.0 --verbose

# Override elasticsearch.yml config, otherwise plug-in install will fail
ADD elasticsearch.yml ${ES_INSTALL}/config/elasticsearch.yml

VOLUME /data

COPY docker-entrypoint.sh /

USER elasticsearch
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 9200 9300

CMD ["elasticsearch"]