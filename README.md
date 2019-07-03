# ElasticSearch on Kubernetes
[![Build Status](https://travis-ci.org/UKHomeOffice/docker-elasticsearch.svg?branch=master)](https://travis-ci.org/UKHomeOffice/docker-elasticsearch)
[![Docker Repository on Quay](https://quay.io/repository/ukhomeofficedigital/elasticsearch/status "Docker Repository on Quay")](https://quay.io/repository/ukhomeofficedigital/elasticsearch)

ElasticSearch 5.6.16 with kubernetes discovery plugin for simple deployment and
discovery.

### Configuration
Configuration is done via environment variables.

The following configuration defaults may not necessarily be set to the same
values in [kube/](kube/) example files.

* `CLUSTER_NAME`: ElasticSearch cluster name. Default: `elasticsearch`.
* `NODE_NAME`: Node name. Default: `${HOSTNAME}` (kubernetes assigned pod name by default).
* `PATH_DATA`: Path where ES stores its data. Default: `/data`.
* `ELASTIC_SEARCH_HEAP_SIZE`: JVM heap size. Default: `450m`. If you adjust this parameter,
  make sure to increase container limits as well.
* `INDEX_AUTO_EXPAND_REPLICAS`: Whether to automatically expand index replicas
  across data nodes. Default: `false`.
* `INDEX_NUMBER_OF_SHARDS`: The default number of primary shards for each index. Default: `5`.
* `INDEX_NUMBER_OF_REPLICAS`: The number of replicas per shard that an index should create. Default `1`.
* `INDEX_REFRESH_INTERVAL`: How often to refresh indexes. Default: `1s`.
* `GATEWAY_EXPECTED_MASTER_NODES` - See https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-gateway.html
* `GATEWAY_EXPECTED_DATA_NODES` - See https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-gateway.html
* `MEM_LOCK` - Whether to enable bootstrap.memory_lock. Default: `true`.
* `NODE_MASTER`: Whether this node can be a master node. Default: `true`.
* `NODE_DATA`: Whether this node can be a data node. Default: `true`.
* `NODE_INGEST`: Whether this node can be a data ingesting node. Default: `true`.
* `HTTP_ENABLE`: Whether this node can be a client (HTTP) node. Default: `true`.
* `HTTP_BIND_HOST`: http bind address.. Default: `0.0.0.0`.
* `KUBERNETES_SERVICE`: kubernetes service name for master nodes. Default `elasticsearch-master`.
* `ENABLE_TRANSPORT_SSL`: whether to enable search-guard transport SSL. Default: `false`.
* `DISCOVERY_ZEN_FD_PING_INTERVAL` - see https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-discovery-zen.html#fault-detection
* `DISCOVERY_ZEN_FD_PING_TIMEOUT` - see https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-discovery-zen.html#fault-detection
* `DISCOVERY_ZEN_FD_PING_RETRIES` - see https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-discovery-zen.html#fault-detection
* `DISCOVERY_ZEN_PUBLISH_TIMEOUT` - see https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-discovery-zen.html#_cluster_state_updates
* `DISCOVERY_ZEN_UNICAST_HOST` - see https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-discovery-zen.html#fault-detection. Default `elasticsearch`
* `DISCOVERY_ZEN_MINIMUM_MASTER_NODES` - see https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-discovery-zen.html#master-election. Default: `1`
* `THREAD_POOL_BULK_QUEUE_SIZE` - see https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-threadpool.html
* `INDEX_BUFFER_SIZE` - see https://www.elastic.co/guide/en/elasticsearch/reference/5.1/indexing-buffer.html
* `CLOUD_AWS_S3_ACCESS_KEY` - Cloud AWS S3 access key for repository-s3 plugin. See https://www.elastic.co/guide/en/elasticsearch/plugins/6.8/repository-s3-client.html
* `CLOUD_AWS_S3_SECRET_KEY` - Cloud AWS S3 secret key for repository-s3 plugin. See https://www.elastic.co/guide/en/elasticsearch/plugins/6.8/repository-s3-client.html
* `CLOUD_AWS_S3_ENDPOINT` - Cloud AWS S3 endpoint for repository-s3 plugin. See https://www.elastic.co/guide/en/elasticsearch/plugins/6.8/repository-s3-client.html
* `XPACK_SECURITY_ENABLE` - Whether X-Pack security plugin is enabled. Default: `false`
* `XPACK_SECURITY_AUDIT_ENABLE` - Whether to enable auditing to keep track of attempted and successful interactions with Elasticsearch cluster. Default: `false`.
* `XPACK_SECURITY_AUDIT_INDEX_EVENTS_EXCLUDE` - Excludes the specified auditing events from indexing. By default, no events are excluded. Accepts a string value with comma separated events. See https://www.elastic.co/guide/en/elasticsearch/reference/5.5/auditing-settings.html#index-audit-settings
* `XPACK_SECURITY_AUDIT_LOGFILE_EVENTS_EXCLUDE` - Excludes the specified events from log output. By default, no events are excluded. Accepts a string value with comma separated events. See https://www.elastic.co/guide/en/elasticsearch/reference/5.5/auditing-settings.html#event-audit-settings
* `XPACK_SECURITY_AUDIT_OUTPUT` - The output for audit data. Default: `logfile`. Possible options: `index`, 'logfile'.
* `XPACK_SECURITY_TRANSPORT_SSL_ENABLE` - Whether to enable transport SSL. Default: `false`
* `XPACK_SECURITY_HTTP_SSL_ENABLE` - Whether to enable HTTP SSL. Default: `false`
* `XPACK_SSL_KEY_PATH` - The full path to the node key file. This must be a location within the Elasticsearch configuration directory.
* `XPACK_SSL_CERT_PATH` - The full path to the node certificate. This must be a location within the Elasticsearch configuration directory.
* `XPACK_SSL_CA_CERT_PATH` -  Path to the CA certificate that should be trusted. This path must be a location within the Elasticsearch configuration directory.
* `XPACK_MONITORING_ENABLE` - Whether to enable X-Pack monitoring features. Default: `false`.
* `XPACK_ML_ENABLE` - Whether to enable X-Pack machine learning features. Default: `false`.
* `XPACK_WATCHER_ENABLE` - Whether to enable X-Pack Watcher. Default: `false`.
* `XPACK_EMAIL_DEFAULTS_FROM` - The default FROM email address to be configured for all watches
* `XPACK_EMAIL_SMTP_AUTH` - Whether auth is required for email
* `XPACK_EMAIL_SMTP_STARTTLS_ENABLE` - TLS is enabled for the smtp host
* `XPACK_EMAIL_SMTP_STARTTLS_REQUIRED` - Require TLS communications with the smtp host
* `XPACK_EMAIL_SMTP_HOST` - The SMTP host address
* `XPACK_EMAIL_SMTP_PORT` - The SMTP host port to communicate on (e.g. 25, 587)
* `XPACK_EMAIL_SMTP_USER` - The username for auth with the SMTP host
* `XPACK_EMAIL_SMTP_PASS` - The password for auth with the SMTP host


### Plugins

#### Search Guard SSL
If you want to use transport TLS, please take a look at their documentation
https://github.com/floragunncom/search-guard-ssl.

ElasticSearch expects `truststore.jks` and `keystore.jks` files to be placed in
`/elasticsearch/config/certs`. Keystore cert/key alias must be `cert` and
truststore alias - `ca`. Bare in mind that certs need to be signed by the same
CA. If you use vault, then take a look at
https://github.com/UKHomeOffice/vaultjks, which could help you to get your
certs from vault and create keystore files.


### Deployment
By default if you start the docker container, ElasticSearch will start in
standalone mode.

Deploying onto a Kubernetes cluster is fairly easy. There are example
kubernetes controller and service files in [kube/](kube/) directory.


#### Deploy Master Node
First of all we need to deploy master service for ES master nodes to find each
other and other communications between nodes. Then we can create the master
replication controller.

```bash
$ kubectl create -f kube/es-master-svc.yaml
$ kubectl create -f kube/es-master-rc.yaml
```

Wait a few seconds and verify whether it is up and running. You can also scale
the master nodes to 3.

```bash
$ kubectl logs -f es-master-fdfw -c elasticsearch
$ kubectl scale --replicas=3 rc/es-master
```

#### Deploy Client and Data Nodes
Once the master node is up and running, you can start deploying the rest of the cluster.

```bash
$ kubectl create -f kube/es-svc.yaml
$ kubectl create -f kube/es-client-rc.yaml
$ kubectl create -f kube/es-data-rc.yaml
```
