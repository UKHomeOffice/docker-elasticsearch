# CHANGELOG

## 5.6.16-1

Upgrades Elasticsearch to version 5.6.16: https://www.elastic.co/guide/en/elasticsearch/reference/5.6/es-release-notes.html

Upgrades search-guard-ssl plugin to 5.6.16.

Removes elasticsearch-cloud-kubernetes plugin. As noted in the project it is no longer under development and should be replaced with a headless service instead (see below):
https://github.com/fabric8io/elasticsearch-cloud-kubernetes/

The following environment variables are REMOVED:

* `NODE_LOCAL`
* `DISCOVERY_TYPE`
* `CLOUD_AWS_S3_REGION`

The following environment variables are ADDED:

* `MEM_LOCK` - Whether to enable bootstrap.memory_lock. Default: `true`.
* `DISCOVERY_ZEN_UNICAST_HOST` - see https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-discovery-zen.html#fault-detection. Default `elasticsearch`
* `CLOUD_AWS_S3_ENDPOINT` - Cloud AWS S3 endpoint for repository-s3 plugin. See https://www.elastic.co/guide/en/elasticsearch/plugins/6.8/repository-s3-client.html

Other changes:

`log4j2.properties` is modified as follows:

`appender.console.layout.pattern = [%d{ISO8601}][%-5p][%-25c{1.}] %marker%m%n`
becomes:
`appender.console.layout.pattern = [%d{ISO8601}][%-5p][%-25c{1.}] [%node_name]%marker%m%n`

`elasticsearch-keystore` is now initialised and used to store the s3 default client access and secret key:

```
# Create keystore
/elasticsearch/bin/elasticsearch-keystore create

add_to_keystore s3.client.default.access_key ${CLOUD_AWS_S3_ACCESS_KEY}
add_to_keystore s3.client.default.secret_key ${CLOUD_AWS_S3_SECRET_KEY}
```

### Notes:

Headless service replaces elasticsearch-cloud-kubernetes plugin.

Instead of using a plugin to discover the kubernetes nodes, it is now recommended to configure a headless service instead and use this as the value of `DISCOVERY_ZEN_UNICAST_HOST`:

```
---
apiVersion: v1
kind: Service
metadata:
  name: elasticsearch-discovery
  namespace: logging
  labels:
    name: elasticsearch-discovery
  annotations:
    service.alpha.kubernetes.io/tolerate-unready-endpoints: "true"
spec:
  type: ClusterIP
  clusterIP: None
  selector:
    service: elasticsearch
  ports:
    - name: cluster
      port: 9300
      protocol: TCP
      targetPort: 9300
  publishNotReadyAddresses: true
  sessionAffinity: None
```

With the above example (note in particular `clusterIP: None` but also the annotation and `publishNotReadyAddresses` flag) you would set `DISCOVERY_ZEN_UNICAST_HOST=elasticsearch-discovery`

# END
