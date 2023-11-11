<https://prometheus.io/docs/tutorials/getting_started/>
<https://prometheus.io/docs/tutorials/getting_started/#show-me-how-it-is-done>
One can scrape multiple useful metrics to understand what is happening in the application and create multiple charts on them. Group the charts into a dashboard and use it to get an overview of the application.

Let’s get our hands dirty and setup Prometheus. Prometheus is written using Go and all you need is the binary compiled for your operating system. Download the binary corresponding to your operating system from here and add the binary to your path.

Prometheus exposes its own metrics which can be consumed by itself or another Prometheus server.

Now that we have Prometheus installed, the next step is to run it. All that we need is just the binary and a configuration file. Prometheus uses yaml files for configuration.

global:
  scrape_interval: 15s

scrape_configs:

- job_name: prometheus
    static_configs:
  - targets: ["localhost:9090"]
In the above configuration file we have mentioned the scrape_interval, i.e how frequently we want Prometheus to scrape the metrics. We have added scrape_configs which has a name and target to scrape the metrics from. Prometheus by default listens on port 9090. So add it to targets.

prometheus --config.file=prometheus.yml

Now we have Prometheus up and running and scraping its own metrics every 15s. Prometheus has standard exporters available to export metrics. Next we will run a node exporter which is an exporter for machine metrics and scrape the same using Prometheus. (Download node metrics exporter.)

Run the node exporter in a terminal.

./node_exporter

Node exporter

Next, add node exporter to the list of scrape_configs:

global:
  scrape_interval: 15s

scrape_configs:

- job_name: prometheus
    static_configs:
  - targets: ["localhost:9090"]
- job_name: node_exporter
    static_configs:
  - targets: ["localhost:9100"]

<https://prometheus.io/docs/tutorials/instrumenting_http_server_in_go/>
