<https://prometheus.io/docs/tutorials/getting_started/>

BASIC ARCHITECTURE OF PROMETHEUS
The basic components of a Prometheus setup are:

Prometheus Server (the server which scrapes and stores the metrics data).
Targets to be scraped, for example an instrumented application that exposes its metrics, or an exporter that exposes metrics of another application.
Alertmanager to raise alerts based on preset rules.
(Note: Apart from this Prometheus has push_gateway which is not covered here).

**![Prometheus arch](https://prometheus.io/assets/tutorial/architecture.png)**

Let's consider a web server as an example application and we want to extract a certain metric like the number of API calls processed by the web server. So we add certain instrumentation code using the Prometheus client library and expose the metrics information. Now that our web server exposes its metrics we can configure Prometheus to scrape it. Now Prometheus is configured to fetch the metrics from the web server which is listening on xyz IP address port 7500 at a specific time interval, say, every minute.

At 11:00:00 when I make the server public for consumption, the application calculates the request count and exposes it, Prometheus simultaneously scrapes the count metric and stores the value as 0.

By 11:01:00 one request is processed. The instrumentation logic in the server increments the count to 1. When Prometheus scrapes the metric the value of count is 1 now.

By 11:02:00 two more requests are processed and the request count is 1+2 = 3 now. Similarly metrics are scraped and stored.

The user can control the frequency at which metrics are scraped by Prometheus.

Time Stamp Request Count (metric)
11:00:00 0
11:01:00 1
11:02:00 3
(Note: This table is just a representation for understanding purposes. Prometheus doesn’t store the values in this exact format)

Prometheus also has an API which allows to query metrics which have been stored by scraping. This API is used to query the metrics, create dashboards/charts on it etc. PromQL is used to query these metrics.

A simple Line chart created on the Request Count metric will look like this

**![Request count](https://prometheus.io/assets/tutorial/sample_graph.png)**
