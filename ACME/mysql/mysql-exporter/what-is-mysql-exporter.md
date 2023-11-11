# looks like there are 2 or more exporters

<https://github.com/prometheus/mysqld_exporter> // this one seems the most active
<https://artifacthub.io/packages/helm/prometheus-community/prometheus-mysql-exporter#configuration>  // this is the helm chart for the most active exporter

(<https://grafana.com/oss/prometheus/exporters/mysql-exporter/>)
<https://github.com/prometheus/mysqld_exporter/tree/main/mysqld-mixin>
<https://artifacthub.io/packages/helm/prometheus-community/prometheus-mysql-exporter>

## What is MySQL Exporter?

**[MySQL Exporter](https://exporterhub.io/exporter/mysql-exporter/#:~:text=The%20MySQL%20exporter%20is%20required,ingest%20the%20time%20series%20data.)**
"The MySQL exporter is required to monitor and expose MySQL metrics. It queries MySQL, scraps the data, and exposes the metrics to a Kubernetes service endpoint that can further be scrapped by Prometheus to ingest the time series data.

On deployment, this exporter scraps OPlog, replica set, server status, sharding, and storage engine metrics. It handles all metrics exposed by MySQL monitoring commands. It loops over all the fields exposed in diagnostic commands and tries to get data from them. The MySQL exporter helps users get crucial and continuous information about the database which is difficult to get from MySQL directly.
"

**[MySQL database performance](https://scalegrid.io/blog/how-to-monitor-mysql-deployments-with-prometheus-and-grafana-at-scalegrid/)**
"
Monitoring your MySQL database performance in real-time helps you immediately identify problems and other factors that could be causing issues now or in the future. It’s also a good way to determine which components of the database can be enhanced or optimized to increase your efficiency and performance. This is usually done through monitoring software and tools either built-in to the database management software or installed from third-party providers.
"

## How do you set up an exporter for Prometheus?

With the latest version of Prometheus (2.33 as of February 2022), these are the ways to set up a Prometheus exporter:

Method 1 - Native
Supported by Prometheus since the beginning
To set up an exporter in native way a Prometheus config needs to be updated to add the target.
A sample configuration:

## scrape_config job

- job_name: mysql-staging
    scrape_interval: 45s
    scrape_timeout:  30s
    metrics_path: "/metrics"
    static_configs:
  - targets:
    - <Mysql exporter endpoint>

## Method 2 - Service Discovery

This method is applicable for Kubernetes deployment only
With this, a default scrap config can be added to the prometheus.yaml file and an annotation can be added to the exporter service. With this, Prometheus will automatically start scrapping the data from the services with the mentioned path.

Prometheus.yaml

```yaml
     - job_name: kubernetes-services   
        scrape_interval: 15s
        scrape_timeout: 10s
        kubernetes_sd_configs:
        - role: service
        relabel_configs:
        # Example relabel to scrape only endpoints that have
        # prometheus.io/scrape: "true" annotation.
        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scrape]
          action: keep
          regex: true
        #  prometheus.io/path: "/scrape/path" annotation.
        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_path]
          action: replace
          target_label: __metrics_path__
          regex: (.+)
        #  prometheus.io/port: "80" annotation.
        - source_labels: [__address__, __meta_kubernetes_service_annotation_prometheus_io_port]
          action: replace
          target_label: __address__
          regex: (.+)(?::\d+);(\d+)
          replacement: $1:$2
```

## Exporter service

```yaml
 annotations:
    prometheus.io/path: /metrics
    prometheus.io/scrape: "true"
```

## Method 3 - Prometheus Operator

Setting up a service monitor
The Prometheus operator supports an automated way of scraping data from the exporters by setting up a service monitor Kubernetes object. A sample service monitor for MySQL can be found here.
These are the necessary steps:

Step 1

Add/update Prometheus operator’s selectors. By default, the Prometheus operator comes with empty selectors which will select every service monitor available in the cluster for scrapping the data.

To check your Prometheus configuration:

```yaml
Kubectl get prometheus -n <namespace> -o yaml

ruleNamespaceSelector: {}
    ruleSelector:
      matchLabels:
        app: kube-prometheus-stack
        release: kps
    scrapeInterval: 1m
    scrapeTimeout: 10s
    securityContext:
      fsGroup: 2000
      runAsGroup: 2000
      runAsNonRoot: true
      runAsUser: 1000
    serviceAccountName: kps-kube-prometheus-stack-prometheus
    serviceMonitorNamespaceSelector: {}
    serviceMonitorSelector:
      matchLabels:
        release: kps
```

Here you can see that this Prometheus configuration is selecting all the service monitors with the label release = kps

So with this, if you are modifying the default Prometheus operator configuration for service monitor scrapping, make sure you use the right labels in your service monitor as well.

Step 2

Add a service monitor and make sure it has a matching label and namespace for the Prometheus service monitor selectors (serviceMonitorNamespaceSelector & serviceMonitorSelector).

To enable service monitor run:

helm install <RELEASE_NAME> prometheus-community/prometheus-mysql-exporter --set serviceMonitor.enabled=true

Sample configuration:

```yaml
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  annotations:
    meta.helm.sh/release-name: mysql-exporter
    meta.helm.sh/release-namespace: monitor
  generation: 1
  labels:
    app: prometheus-mysql-exporter
    app.kubernetes.io/managed-by: Helm
    heritage: Helm
    release: kps
  name: mysql-exporter-prometheus-mysql-exporter
  namespace: monitor
spec:
  endpoints:
  - interval: 15s
    port: mysql-exporter
  selector:
    matchLabels:
      app: prometheus-mysql-exporter
      release: mysql-exporter
```

Here you can see we have a matching label on the service monitor release = kps that we are specifying in the Prometheus operator scrapping configuration.

Metrics
The following ones are handpicked metrics that will provide insights into MySQL.

MySQL is up
This shows whether the last scrape of metrics from MySQL was able to connect to the server.
➡ The key of the exporter metric is “mysql_up”
➡ The value of the metric is a boolean -  1 or 0 which symbolizes if MySQL is up or down respectively (1 for yes, 0 for no)
Too many connections
The permitted number of connections is controlled by the max_connections system variable. If all available connections are in use by other clients, the new clients trying to connect will encounter “too many connections” errors when attempting to connect to the MySQL server. Therefore, it is important to monitor the number of connected clients.
➡ The metric “ mysql_global_status_threads_connected” shows the total active connections on MySQL
➡ The number should be calculated based on “mysql_global_variables_max_connections” which is the maximum number of connections configured
 MySQL slow queries
Slow queries cause/indicate performance issues. Like many databases, MySQL keeps a log for these slow queries. The number of entries in this log can be consulted with the metric key below.
➡ The metric key is “mysql_global_status_slow_query”
➡ The value provided will be the count of slow queries
Buffer pool cache
MySQL InnoDB (default storage engine) uses an area of memory called the buffer pool to cache data for tables and indexes. It uses an in-memory cache to optimize the disk read and write operations. Buffer pool metrics and other resource metrics are primarily useful for investigating performance issues.
➡ The metric “mysql_global_status_innodb_buffer_pool_reads” shows the number of logical reads that InnoDB could not satisfy from the buffer pool and had to read directly from the disk
Total MySQL InnoDB log waits
This metric provides insight into the number of times that the log buffer was too small and a wait was required for it to be flushed before continuing.
➡ The metric  “mysql_global_status_innodb_log_waits” indicates InnoDB log writes are stalling
