stackstate
==========
Helm chart for StackState

Current chart version is `0.4.24`

Source code can be found [here](https://gitlab.com/stackvista/stackstate.git)

## Chart Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | kafka | 7.2.9 |
| https://charts.bitnami.com/bitnami | zookeeper | 5.4.3 |
| https://helm-test.stackstate.io | anomaly-detection | 1.16.6 |
| https://helm.stackstate.io | common | 0.4.3 |
| https://helm.stackstate.io | elasticsearch | 7.6.2-stackstate.3 |
| https://helm.stackstate.io | hbase | 0.1.29 |

## Required Values

In order to successfully install this chart, you **must** provide the following variables:
* `stackstate.license.key`
* `stackstate.receiver.baseUrl`

Install them on the command line on Helm with the following command:

```shell
helm install \
--set stackstate.license.key=<your-license-key> \
--set stackstate.receiver.baseUrl=<your-base-url> \
stackstate/stackstate
```

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| anomaly-detection.enabled | bool | `false` | enable anomaly detection |
| anomaly-detection.imageTag | string | `"latest"` | image tag |
| anomaly-detection.ingress | object | `{"annotations":{},"enabled":false,"hostname":null,"hosts":[],"port":8090,"tls":null}` | Status interface ingress |
| anomaly-detection.ingress.enabled | bool | `false` | enable anomaly detection ingress |
| anomaly-detection.ingress.hostname | string | `nil` | Status interface hostname e.g. spotlight.local.domain |
| anomaly-detection.stackstate.elasticSearchUri | string | `"stackstate-elasticsearch-master:9200"` |  |
| anomaly-detection.stackstate.instance | string | `"stackstate-server:7070"` |  |
| anomaly-detection.stackstate.password | string | `nil` | Stackstate API password |
| anomaly-detection.stackstate.username | string | `nil` | Stackstate API username |
| caspr.enabled | bool | `false` | Enable CASPR compatible values. |
| elasticsearch.clusterHealthCheckParams | string | `"wait_for_status=yellow&timeout=1s"` | The Elasticsearch cluster health status params that will be used by readinessProbe command |
| elasticsearch.clusterName | string | `"stackstate-elasticsearch"` | Name override for Elasticsearch child chart. **Don't change unless otherwise specified; this is a Helm v2 limitation, and will be addressed in a later Helm v3 chart.** |
| elasticsearch.enabled | bool | `true` | Enable / disable chart-based Elasticsearch. |
| elasticsearch.extraEnvs | list | `[{"name":"action.auto_create_index","value":"true"},{"name":"indices.query.bool.max_clause_count","value":"10000"}]` | Extra settings that StackState uses for Elasticsearch. |
| elasticsearch.imageTag | string | `"7.4.1"` | Elasticsearch version. |
| elasticsearch.minimumMasterNodes | int | `2` | Minimum number of Elasticsearch master nodes. |
| elasticsearch.nodeGroup | string | `"master"` |  |
| elasticsearch.replicas | int | `3` | Number of Elasticsearch replicas. |
| elasticsearch.volumeClaimTemplate | object | `{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"250Gi"}}}` | PVC template defaulting to 250Gi default volumes |
| global.receiverApiKey | string | `""` | API key to be used by the Receiver; if no key is provided, a random one will be generated for you. |
| hbase.enabled | bool | `true` | Enable / disable chart-based HBase. |
| hbase.hbase.master.replicaCount | int | `2` | Number of HBase master node replicas. |
| hbase.hbase.regionserver.replicaCount | int | `3` | Number of HBase regionserver node replicas. |
| hbase.hdfs.datanode.replicaCount | int | `3` | Number of HDFS datanode replicas. |
| hbase.hdfs.secondarynamenode.enabled | bool | `true` |  |
| hbase.stackgraph.image.tag | string | `"1.5.7"` | The StackGraph server version, must be compatible with the StackState version |
| hbase.tephra.replicaCount | int | `2` | Number of Tephra replicas. |
| hbase.zookeeper.enabled | bool | `false` | Disable Zookeeper from the HBase chart **Don't change unless otherwise specified**. |
| hbase.zookeeper.externalServers | string | `"stackstate-zookeeper-headless"` | External Zookeeper if not used bundled Zookeeper chart **Don't change unless otherwise specified**. |
| ingress.annotations | object | `{}` | Annotations for ingress objects. |
| ingress.enabled | bool | `false` | Enable use of ingress controllers. |
| ingress.hosts | list | `[]` | List of ingress hostnames; the paths are fixed to StackState backend services |
| ingress.path | string | `"/"` |  |
| ingress.tls | list | `[]` | List of ingress TLS certificates to use. |
| kafka.enabled | bool | `true` | Enable / disable chart-based Kafka. |
| kafka.externalZookeeper.servers | string | `"stackstate-zookeeper-headless"` | External Zookeeper if not used bundled Zookeeper chart **Don't change unless otherwise specified**. |
| kafka.fullnameOverride | string | `"stackstate-kafka"` | Name override for Kafka child chart. **Don't change unless otherwise specified; this is a Helm v2 limitation, and will be addressed in a later Helm v3 chart.** |
| kafka.image.tag | string | `"2.3.1-debian-9-r41"` | Default tag used for Kafka. **Since StackState relies on this specific version, it's advised NOT to change this.** |
| kafka.livenessProbe.initialDelaySeconds | int | `45` | Delay before readiness probe is initiated. |
| kafka.logRetentionHours | int | `24` | The minimum age of a log file to be eligible for deletion due to age. |
| kafka.metrics.jmx.enabled | bool | `true` | Whether or not to expose JMX metrics to Prometheus. |
| kafka.metrics.kafka.enabled | bool | `true` | Whether or not to create a standalone Kafka exporter to expose Kafka metrics. |
| kafka.metrics.serviceMonitor.enabled | bool | `false` | If `true`, creates a Prometheus Operator `ServiceMonitor` (also requires `kafka.metrics.kafka.enabled` or `kafka.metrics.jmx.enabled` to be `true`). |
| kafka.metrics.serviceMonitor.interval | string | `"20s"` | How frequently to scrape metrics. |
| kafka.metrics.serviceMonitor.selector | object | `{}` | Selector to target Prometheus instance. |
| kafka.persistence.size | string | `"50Gi"` | Size of persistent volume for each Kafka pod |
| kafka.readinessProbe.initialDelaySeconds | int | `45` | Delay before readiness probe is initiated. |
| kafka.replicaCount | int | `3` | Number of Kafka replicas. |
| kafka.resources | object | `{"limits":{"memory":"2Gi"},"requests":{"memory":"2Gi"}}` | Kafka resources per pods. |
| kafka.zookeeper.enabled | bool | `false` | Disable Zookeeper from the Kafka chart **Don't change unless otherwise specified**. |
| networkPolicy.enabled | bool | `false` | Enable creating of `NetworkPolicy` object and associated rules for StackState. |
| networkPolicy.spec | object | `{"ingress":[{"from":[{"podSelector":{}}]}],"podSelector":{"matchLabels":{}},"policyTypes":["Ingress"]}` | `NetworkPolicy` rules for StackState. |
| stackstate.admin.authentication.enabled | bool | `true` | Enable basic auth protection for the /admin endpoint. |
| stackstate.components.all.affinity | object | `{}` | Affinity settings for pod assignment on all components. |
| stackstate.components.all.elasticsearchEndpoint | string | `""` | **Required if `elasticsearch.enabled` is `false`** Endpoint for shared Elasticsearch cluster. |
| stackstate.components.all.extraEnv.open | object | `{}` | Extra open environment variables to inject into pods for all components. |
| stackstate.components.all.extraEnv.secret | object | `{}` | Extra secret environment variables to inject into pods via a `Secret` object for all components. |
| stackstate.components.all.image.pullPolicy | string | `"Always"` | The default pullPolicy used for all stateless components of StackState; invividual service `pullPolicy`s can be overriden (see below). |
| stackstate.components.all.image.pullSecretDockerConfigJson | string | `nil` | Value of `.dockerconfigjson` of ImagePullSecret to use for all pods. |
| stackstate.components.all.image.pullSecretName | string | `nil` | Name of ImagePullSecret to use for all pods. |
| stackstate.components.all.image.registry | string | `"quay.io"` | Base container image registry for all containers, except for the wait container |
| stackstate.components.all.image.repositorySuffix | string | `"-stable"` |  |
| stackstate.components.all.image.tag | string | `"sts-private-v1-16-0-golf"` | The default tag used for all stateless components of StackState; invividual service `tag`s can be overriden (see below). |
| stackstate.components.all.kafkaEndpoint | string | `""` | **Required if `elasticsearch.enabled` is `false`** Endpoint for shared Kafka broker. |
| stackstate.components.all.metrics.enabled | bool | `true` | Enable metrics port. |
| stackstate.components.all.metrics.servicemonitor.additionalLabels | object | `{}` | Additional labels for targeting Prometheus operator instances. |
| stackstate.components.all.metrics.servicemonitor.enabled | bool | `false` | Enable `ServiceMonitor` object; `all.metrics.enabled` *must* be enabled. |
| stackstate.components.all.nodeSelector | object | `{}` | Node labels for pod assignment on all components. |
| stackstate.components.all.tolerations | list | `[]` | Toleration labels for pod assignment on all components. |
| stackstate.components.all.zookeeperEndpoint | string | `""` | **Required if `zookeeper.enabled` is `false`** Endpoint for shared Zookeeper nodes. |
| stackstate.components.correlate.affinity | object | `{}` | Affinity settings for pod assignment. |
| stackstate.components.correlate.extraEnv.open | object | `{}` | Extra open environment variables to inject into pods. |
| stackstate.components.correlate.extraEnv.secret | object | `{}` | Extra secret environment variables to inject into pods via a `Secret` object. |
| stackstate.components.correlate.image.pullPolicy | string | `""` | `pullPolicy` used for the `correlate` component Docker image; this will override `stackstate.components.all.image.pullPolicy` on a per-service basis. |
| stackstate.components.correlate.image.repository | string | `"stackstate/stackstate-correlate"` | Repository of the correlate component Docker image. |
| stackstate.components.correlate.image.tag | string | `""` | Tag used for the `correlate` component Docker image; this will override `stackstate.components.all.image.tag` on a per-service basis. |
| stackstate.components.correlate.nodeSelector | object | `{}` | Node labels for pod assignment. |
| stackstate.components.correlate.poddisruptionbudget | object | `{"maxUnavailable":1}` | PodDisruptionBudget settings for `correlate` pods. |
| stackstate.components.correlate.replicaCount | int | `1` | Number of `correlate` replicas. |
| stackstate.components.correlate.resources | object | `{"limits":{"memory":"2Gi"},"requests":{"memory":"2Gi"}}` | Resource allocation for `correlate` pods. |
| stackstate.components.correlate.tolerations | list | `[]` | Toleration labels for pod assignment. |
| stackstate.components.k2es.affinity | object | `{}` | Affinity settings for pod assignment. |
| stackstate.components.k2es.extraEnv.open | object | `{}` | Extra open environment variables to inject into pods. |
| stackstate.components.k2es.extraEnv.secret | object | `{}` | Extra secret environment variables to inject into pods via a `Secret` object. |
| stackstate.components.k2es.image.pullPolicy | string | `""` | `pullPolicy` used for the `k2es` component Docker image; this will override `stackstate.components.all.image.pullPolicy` on a per-service basis. |
| stackstate.components.k2es.image.repository | string | `"stackstate/stackstate-kafka-to-es"` | Repository of the k2es component Docker image. |
| stackstate.components.k2es.image.tag | string | `""` | Tag used for the `k2es` component Docker image; this will override `stackstate.components.all.image.tag` on a per-service basis. |
| stackstate.components.k2es.nodeSelector | object | `{}` | Node labels for pod assignment. |
| stackstate.components.k2es.poddisruptionbudget | object | `{"maxUnavailable":1}` | PodDisruptionBudget settings for `k2es` pods. |
| stackstate.components.k2es.replicaCount | int | `1` | Number of `k2es` replicas. |
| stackstate.components.k2es.resources | object | `{"limits":{"memory":"1Gi"},"requests":{"memory":"1Gi"}}` | Resource allocation for `k2es` pods. |
| stackstate.components.k2es.tolerations | list | `[]` | Toleration labels for pod assignment. |
| stackstate.components.kafkaTopicCreate.image.registry | string | `"docker.io"` | Base container image registry for kafka-topic-create containers. |
| stackstate.components.kafkaTopicCreate.image.repository | string | `"bitnami/kafka"` | Base container image repository for kafka-topic-create containers. |
| stackstate.components.kafkaTopicCreate.image.tag | string | `"latest"` | Container image tag for kafka-topic-create containers. |
| stackstate.components.nginxPrometheusExporter.image.registry | string | `"docker.io"` | Base container image registry for nginx-prometheus-exporter containers. |
| stackstate.components.nginxPrometheusExporter.image.repository | string | `"nginx/nginx-prometheus-exporter"` | Base container image repository for nginx-prometheus-exporter containers. |
| stackstate.components.nginxPrometheusExporter.image.tag | string | `"0.4.2"` | Container image tag for nginx-prometheus-exporter containers. |
| stackstate.components.receiver.affinity | object | `{}` | Affinity settings for pod assignment. |
| stackstate.components.receiver.extraEnv.open | object | `{}` | Extra open environment variables to inject into pods. |
| stackstate.components.receiver.extraEnv.secret | object | `{}` | Extra secret environment variables to inject into pods via a `Secret` object. |
| stackstate.components.receiver.image.pullPolicy | string | `""` | `pullPolicy` used for the `receiver` component Docker image; this will override `stackstate.components.all.image.pullPolicy` on a per-service basis. |
| stackstate.components.receiver.image.repository | string | `"stackstate/stackstate-receiver"` | Repository of the receiver component Docker image. |
| stackstate.components.receiver.image.tag | string | `""` | Tag used for the `receiver` component Docker image; this will override `stackstate.components.all.image.tag` on a per-service basis. |
| stackstate.components.receiver.nodeSelector | object | `{}` | Node labels for pod assignment. |
| stackstate.components.receiver.poddisruptionbudget | object | `{"maxUnavailable":1}` | PodDisruptionBudget settings for `receiver` pods. |
| stackstate.components.receiver.replicaCount | int | `1` | Number of `receiver` replicas. |
| stackstate.components.receiver.resources | object | `{"limits":{"memory":"2Gi"},"requests":{"memory":"1Gi"}}` | Resource allocation for `receiver` pods. |
| stackstate.components.receiver.tolerations | list | `[]` | Toleration labels for pod assignment. |
| stackstate.components.router.affinity | object | `{}` | Affinity settings for pod assignment. |
| stackstate.components.router.extraEnv.open | object | `{}` | Extra open environment variables to inject into pods. |
| stackstate.components.router.extraEnv.secret | object | `{}` | Extra secret environment variables to inject into pods via a `Secret` object. |
| stackstate.components.router.image.pullPolicy | string | `"Always"` | `pullPolicy` used for the `router` component Docker image; this will override `stackstate.components.all.image.pullPolicy` on a per-service basis. |
| stackstate.components.router.image.registry | string | `"docker.io"` | Registry of the router component Docker image. |
| stackstate.components.router.image.repository | string | `"envoyproxy/envoy-alpine"` | Repository of the router component Docker image. |
| stackstate.components.router.image.tag | string | `"v1.12.1"` | Tag used for the `router` component Docker image; this will override `stackstate.components.all.image.tag` on a per-service basis. |
| stackstate.components.router.nodeSelector | object | `{}` | Node labels for pod assignment. |
| stackstate.components.router.poddisruptionbudget | object | `{"maxUnavailable":1}` | PodDisruptionBudget settings for `router` pods. |
| stackstate.components.router.replicaCount | int | `1` | Number of `router` replicas. |
| stackstate.components.router.resources | object | `{"limits":{"cpu":"100m","memory":"128Mi"},"requests":{"cpu":"100m","memory":"128Mi"}}` | Resource allocation for `router` pods. |
| stackstate.components.router.tolerations | list | `[]` | Toleration labels for pod assignment. |
| stackstate.components.server.affinity | object | `{}` | Affinity settings for pod assignment. |
| stackstate.components.server.config | string | `""` | Configuration file contents to customize the default StackState configuration, environment variables have higher precedence and can be used as overrides. StackState configuration is in the [HOCON](https://github.com/lightbend/config/blob/master/HOCON.md) format, see [StackState documentation](https://docs.stackstate.com/setup/installation/kubernetes/) for examples. |
| stackstate.components.server.extraEnv.open | object | `{}` | Extra open environment variables to inject into pods. |
| stackstate.components.server.extraEnv.secret | object | `{}` | Extra secret environment variables to inject into pods via a `Secret` object. |
| stackstate.components.server.image.pullPolicy | string | `""` | `pullPolicy` used for the `server` component Docker image; this will override `stackstate.components.all.image.pullPolicy` on a per-service basis. |
| stackstate.components.server.image.repository | string | `"stackstate/stackstate-server"` | Repository of the server component Docker image. |
| stackstate.components.server.image.tag | string | `""` | Tag used for the `server` component Docker image; this will override `stackstate.components.all.image.tag` on a per-service basis. |
| stackstate.components.server.nodeSelector | object | `{}` | Node labels for pod assignment. |
| stackstate.components.server.poddisruptionbudget | object | `{"maxUnavailable":1}` | PodDisruptionBudget settings for `server` pods. |
| stackstate.components.server.replicaCount | int | `1` | Number of `server` replicas. |
| stackstate.components.server.resources | object | `{"limits":{"memory":"8Gi"},"requests":{"memory":"8Gi"}}` | Resource allocation for `server` pods. |
| stackstate.components.server.tolerations | list | `[]` | Toleration labels for pod assignment. |
| stackstate.components.ui.affinity | object | `{}` | Affinity settings for pod assignment. |
| stackstate.components.ui.extraEnv.open | object | `{}` | Extra open environment variables to inject into pods. |
| stackstate.components.ui.extraEnv.secret | object | `{}` | Extra secret environment variables to inject into pods via a `Secret` object. |
| stackstate.components.ui.image.pullPolicy | string | `""` | `pullPolicy` used for the `ui` component Docker image; this will override `stackstate.components.all.image.pullPolicy` on a per-service basis. |
| stackstate.components.ui.image.repository | string | `"stackstate/stackstate-ui"` | Repository of the ui component Docker image. |
| stackstate.components.ui.image.tag | string | `""` | Tag used for the `ui` component Docker image; this will override `stackstate.components.all.image.tag` on a per-service basis. |
| stackstate.components.ui.nodeSelector | object | `{}` | Node labels for pod assignment. |
| stackstate.components.ui.poddisruptionbudget | object | `{"maxUnavailable":1}` | PodDisruptionBudget settings for `ui` pods. |
| stackstate.components.ui.replicaCount | int | `2` | Number of `ui` replicas. |
| stackstate.components.ui.resources | object | `{"limits":{"cpu":"50m","memory":"64Mi"},"requests":{"cpu":"50m","memory":"64Mi"}}` | Resource allocation for `ui` pods. |
| stackstate.components.ui.tolerations | list | `[]` | Toleration labels for pod assignment. |
| stackstate.components.wait.image.registry | string | `"docker.io"` | Base container image registry for wait containers. |
| stackstate.components.wait.image.repository | string | `"dokkupaas/wait"` | Base container image repository for wait containers. |
| stackstate.components.wait.image.tag | string | `"latest"` | Container image tag for wait containers. |
| stackstate.license.key | string | `nil` | **PROVIDE YOUR LICENSE KEY HERE** The StackState license key needed to start the server. |
| stackstate.receiver.baseUrl | string | `nil` | **PROVIDE YOUR BASE URL HERE** Externally visible baseUrl of the StackState endpoints. |
| zookeeper.enabled | bool | `true` | Enable / disable chart-based Zookeeper. |
| zookeeper.externalServers | string | `""` | If `zookeeper.enabled` is set to `false`, use this list of external Zookeeper servers instead. |
| zookeeper.fourlwCommandsWhitelist | string | `"mntr, ruok, stat, srvr"` | Zookeeper four-letter-word (FLW) commands that are enabled. |
| zookeeper.fullnameOverride | string | `"stackstate-zookeeper"` | Name override for Zookeeper child chart. **Don't change unless otherwise specified; this is a Helm v2 limitation, and will be addressed in a later Helm v3 chart.** |
| zookeeper.metrics.enabled | bool | `true` | Enable / disable Zookeeper Prometheus metrics. |
| zookeeper.metrics.serviceMonitor.enabled | bool | `false` | Enable creation of `ServiceMonitor` objects for Prometheus operator. |
| zookeeper.metrics.serviceMonitor.selector | object | `{}` | Default selector to use to target a certain Prometheus instance. |
| zookeeper.replicaCount | int | `3` | Default amount of Zookeeper replicas to provision. |