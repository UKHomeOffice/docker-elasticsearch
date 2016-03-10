# ElasticSearch on Kubernetes
[![Build Status](https://travis-ci.org/UKHomeOffice/docker-elasticsearch.svg?branch=master)](https://travis-ci.org/UKHomeOffice/docker-elasticsearch)
[![Docker Repository on Quay](https://quay.io/repository/ukhomeofficedigital/elasticsearch/status "Docker Repository on Quay")](https://quay.io/repository/ukhomeofficedigital/elasticsearch)

ElasticSearch 2.2.x with kubernetes discovery plugin for simple deployment and
discovery.

### Configuration
Configuration is done via environment variables.

The following configuration defaults may not necessarily be set to the same
values in [kube/](kube/) example files.

* `CLUSTER_NAME`: ElasticSearch cluster name. Default: `elasticsearch`.
* `NODE_NAME`: Node name. Default: `${HOSTNAME}` (kubernetes assigned pod name by default).
* `PATH_DATA`: Path where ES stores its data. Default: `/data`.
* `ES_HEAP_SIZE`: JVM heap size. Default: `450m`. If you adjust this parameter,
  make sure to increase container limits as well.
* `INDEX_AUTO_EXPAND_REPLICAS`: Whether to automatically expand index replicas
  across data nodes. Default: `false`.
* `NODE_MASTER`: Whether this node can be a master node. Default: `true`.
* `NODE_DATA`: Whether this node can be a data node. Default: `true`.
* `HTTP_ENABLE`: Whether this node can be a client (HTTP) node. Default: `true`.
* `KUBERNETES_SERVICE`: kubernetes service name for master nodes. Default `elasticsearch-master`.

For more kubernetes discovery plugin related options, see
https://github.com/fabric8io/kubernetes-client. Our examples use just a
standard kubernetes auth token to authenticate against the kubernetes API for
discovery.


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

