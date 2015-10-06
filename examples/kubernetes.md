# Docker Elasticsearch Kubernetes Examples

## History

Most of this work is taken from [pires/kubernetes-elasticsearch-cluster](https://github.com/pires/kubernetes-elasticsearch-cluster/blob/master/README.md)

I've modified the all the replicationcontrollers to include the two settings:
```yaml
        env:
        - name: KUBERNETES_TRUST_CERT
          value: "true"
        - name: CLOUD_ENABLE
          value: "true"
```

See [Kubernetes API trust](#kubernetes-api-trust) for more information on this.

* KUBECONFIG: path to a standard Kubernetes config file to use for authentication configuration.


## Deploy

See [files ./](./)

The instructions below will deploy 3 data pods and a single client and master.
The data will be saved to separate pods which hopefully will use different nodes.

Attention: The Kubernetes pod descriptors use an emptyDir for storing data in each data node container.

TODO: Work out how to ensure separate nodes.
TODO: Add backups

```
kubectl create -f service-account.yaml
kubectl create -f es-discovery-svc.yaml
kubectl create -f es-svc.yaml
kubectl create -f es-master-rc.yaml
```

Wait until `es-master` is provisioned, and
```
kubectl create -f es-client-rc.yaml
```

Wait until `es-client` is provisioned, and
```
kubectl create -f es-data-rc.yaml
```

Wait until `es-data` is provisioned.

Check the Elasticsearch master logs when all running:

`kubectl logs $(kubectl get pods --no-headers=true -l component=elasticsearch,role=master | cut -d' ' -f1)`

## Test

The command below assumes DNS service has been enabled for your cluster 
(if not, you'll need to substitute http://elasticsearch as appropriate):

`kubectl exec -it $(kubectl get pods -l component=elasticsearch,role=master --no-headers=true | cut -d' ' -f1) curl "http://elasticsearch:9200/_cluster/health?pretty"`

## Kubernetes API Trust

If the environment variable for the pods is set to: `KUBERNETES_TRUST_CERT=false', the plugin must trust the Kubernetes SSL CA.

To enable this the following setting is required in the pods:

```yaml
 - name: KUBERNETES_CA_CERTIFICATE_FILE
          value: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
```

For this to work:

* The alt names in the kube-apiserver CA must include the IP address of the api service.
* The `--root-ca-file` must be included in the Kubernetes platform, see below.

```diff
--- a/units/kubernetes/kube-controller-manager.service
+++ b/units/kubernetes/kube-controller-manager.service
@@ -11,6 +11,7 @@ ExecStart=/opt/bin/hyperkube controller-manager \
   --master=https://127.0.0.1:6443 \
   --kubeconfig=%t/kube-scheduler/kubeconfig \
   --service-account-private-key-file=%t/kube-apiserver/kube-apiserver-key.pem \
+  --root-ca-file=/etc/ssl/certs/platform_ca.pem
   --node-monitor-grace-period=60s \
   --pod-eviction-timeout=60s \
   --logtostderr=true
```
