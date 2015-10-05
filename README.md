# Docker Elasticsearch

Docker container for starting an [Elasticsearch](https://www.elastic.co/products/elasticsearch) cluster with [Kubernetes](http://kubernetes.io/) auto discovery support.

## Getting Started

These instructions will cover how to start a container both in Docker and within a [Kubernetes](http://kubernetes.io/) cluster.

### Prerequisites

In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

Optionally:

* A [Kubernetes](http://kubernetes.io/) cluster to enable Kubernetes api discovery of other nodes.

### Usage

### Enviroment Variables

The variables and the defaults are shown below.
By default, the container does not depend on [Kubernetes](http://kubernetes.io/). 

* `CLUSTER_NAME=${CLUSTER_NAME:-elasticsearch-default}`
* `NODE_MASTER=${NODE_MASTER:-true}`
* `NODE_DATA=${NODE_DATA:-true}`
* `HTTP_ENABLE=${HTTP_ENABLE:-true}`
* `MULTICAST=${MULTICAST:-false}`
* `NAMESPACE=${NAMESPACE:-default}`
* `DISCOVERY_SERVICE=${DISCOVERY_SERVICE:-elasticsearch-discovery}`

### Ports

This container exposes:

* `9200` - The http [Elasticsearch](https://www.elastic.co/products/elasticsearch) API
* `9300` - The [Elasticsearch](https://www.elastic.co/products/elasticsearch) transport protocol

The example below will start a single Elasticsearch instance...

```
docker run --name es_thing --rm=true -e 'PROXY_SERVICE_HOST=google.com' -e 'PROXY_SERVICE_PORT=80' -p 9200:9200 -p 9300:9300 quay.io/ukhomeofficedigital/elasticsearch:v0.1.0
```

## Contributing

Feel free to submit pull requests and issues. If it's a particularly large PR, you may wish to discuss
it in an issue first.

Please note that this project is released with a [Contributor Code of Conduct](code_of_conduct.md). 
By participating in this project you agree to abide by its terms.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the 
[tags on this repository](https://github.com/UKHomeOffice/docker-elasticsearch/tags). 

## Authors

* **Lewis Marshall** - *Initial work* - [Lewis Marshall](https://github.com/LewisMarshall)

See also the list of [contributors](https://github.com/UKHomeOffice/docker-elasticsearch/contributors) who 
participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

* Informed from the [official Docker image](https://hub.docker.com/_/elasticsearch/).
* Adapted from [https://github.com/pires/kubernetes-elasticsearch-cluster](https://github.com/pires/docker-elasticsearch-kubernetes)
