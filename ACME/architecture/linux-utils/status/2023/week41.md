# Peace

I love you my son and am here for you.  Do not be anxious or afraid because I am in control of all things around you. I will help you to believe everthing I have taught you my son.

## NEXT

<https://github.com/nestjs/nest/tree/master/sample>
nest.js cat example

## NestJs

<https://medium.com/@swagatachaudhuri/implement-azure-ad-authentication-in-nest-js-1fe947da2c99>

## Metrics - Prometheus & Grafana

**[Prometheus](https://prometheus.io/docs/introduction/overview/)**
**![Prometheus arch](https://prometheus.io/assets/tutorial/architecture.png)**
**![Request count](https://prometheus.io/assets/tutorial/sample_graph.png)**
**[App Dash Board](https://grafana.com/)**
"
What are metrics?
Metrics are numerical measurements in layperson terms. The term time series refers to the recording of changes over time. What users want to measure differs from application to application. For a web server, it could be request times; for a database, it could be the number of active connections or active queries, and so on.

Metrics play an important role in understanding why your application is working in a certain way. Let's assume you are running a web application and discover that it is slow. To learn what is happening with your application, you will need some information. For example, when the number of requests is high, the application may become slow. If you have the request count metric, you can determine the cause and increase the number of servers to handle the load.

Prometheus
Prometheus is a popular open-source monitoring and alerting system. It is designed to collect metrics from various sources, including Kubernetes, and store them in a time-series database. Prometheus can be used to monitor the health and performance of a Kubernetes cluster, and to trigger alerts when certain conditions are met.

Grafana
Grafana is an open-source visualization and analytics platform. It is often used in conjunction with Prometheus to display metrics and provide insights into the performance and health of a system. Grafana provides a range of visualization options, including graphs, gauges, and dashboards, and can be used to monitor a variety of metrics.

RBAC Manager
RBAC Manager is a Kubernetes operator that helps to manage role-based access control (RBAC) in a cluster. It provides a set of custom resources for defining and managing RBAC rules, and includes features such as automatic synchronization of RBAC rules with the cluster state.

"

## What is observability

**[What is observability](https://grafana.com/docs/grafana-cloud/introduction/what-is-observability/)

What is observability?
Observability is the process of making a system’s internal state more transparent. Systems are made observable by the data they produce, which in turn helps you to determine if your infrastructure or application is healthy and functioning normally.

Observability is made up of the following Three Pillars, and Grafana Cloud enables all of them:

Logs: timestamped records of events that happened over time; for example event or error log files
Metrics: numeric representations of data measured over time; such as the number of user logins, or the temperature of a device
Traces: a representation of a chain of related events moving through a system; such as (a) credit card payment made, (b) customer order recorded, and (c) shipping order created.
Observability is powerful because it enables system operators, DevOps practitioners, and Site Reliability Engineers to ask questions about that information. Ultimately we want transparent systems that are easier for operators to understand and maintain. This transparency helps resolve issues more quickly, and make bugs more shallow and easy to spot.

Observability is often talked about together with infrastructure monitoring or application performance monitoring (APM), and while the two are related, they are not the same. Monitoring involves collecting and analyzing data on a system’s performance and behavior, using this information to identify issues and diagnose problems, and then evaluating the data against established standards to determine if the system is functioning as expected. As an example, the more archaic IT Operations monitoring was focused on checks and statuses of a small number of things. In contrast, with the more modern cloud architecture, systems are so complex that the number of metrics increases dramatically and it becomes more of a data analytics challenge. Observability is a more holistic approach to understanding and managing these complex systems. It involves not only collecting data on the system’s behavior, but also creating a deep understanding of the system’s internal workings and how they interact with each other. This can involve instrumenting the system to collect data at various levels, and using techniques such as distributed tracing and log analysis to gain insight into the system’s behavior.

The key difference between monitoring and observability is that monitoring focuses on collecting data, while observability focuses on understanding and interpreting that data in order to gain a deeper understanding of the system’s behavior and performance. Observability is therefore a more proactive and holistic approach to managing complex systems, as it enables teams to identify and address issues before they become serious problems.

## What is MySQL Exporter?

**[MySQL Exporter](https://exporterhub.io/exporter/mysql-exporter/#:~:text=The%20MySQL%20exporter%20is%20required,ingest%20the%20time%20series%20data.)**
"The MySQL exporter is required to monitor and expose MySQL metrics. It queries MySQL, scraps the data, and exposes the metrics to a Kubernetes service endpoint that can further be scrapped by Prometheus to ingest the time series data."

**[MySQL database performance](https://scalegrid.io/blog/how-to-monitor-mysql-deployments-with-prometheus-and-grafana-at-scalegrid/)**
"
Monitoring your MySQL database performance in real-time helps you immediately identify problems and other factors that could be causing issues now or in the future. It’s also a good way to determine which components of the database can be enhanced or optimized to increase your efficiency and performance. This is usually done through monitoring software and tools either built-in to the database management software or installed from third-party providers.
"

## MySQL Metrics

**[MySQL Exporter](https://exporterhub.io/exporter/mysql-exporter/#:~:text=The%20MySQL%20exporter%20is%20required,ingest%20the%20time%20series%20data.)**
"
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
"

## What is data scraping

**[Data scraping](https://targetinternet.com/resources/what-is-data-scraping-and-how-can-you-use-it)
"Data scraping, also known as web scraping, is the process of importing information from a website into a spreadsheet or local file saved on your computer. It’s one of the most efficient ways to get data from the web, and in some cases to channel that data to another website. "

## Time Series Metrics

**[Time Series Metrics](https://www.anodot.com/learning-center/time-series-metrics/#:~:text=What%20are%20Time%20Series%20Metrics,at%20each%20increment%20of%20time.)**
"
What are Time Series Metrics? A time series is a sequence of sequential data points that occur over a particular interval of time. A “metric”, in this case, refers to the piece of data that is tracked at each increment of time.

**[Time Series Metrics](https://www.anodot.com/learning-center/time-series-metrics/#:~:text=What%20are%20Time%20Series%20Metrics,at%20each%20increment%20of%20time.)**
"
What are Time Series Metrics? A time series is a sequence of sequential data points that occur over a particular interval of time. A “metric”, in this case, refers to the piece of data that is tracked at each increment of time.

What are Time Series Metrics?
A time series is a sequence of sequential data points that occur over a particular interval of time. A “metric”, in this case, refers to the piece of data that is tracked at each increment of time.

A time series metric has two main features:

Measurable: this means that you can assign a numeric value to it
Variable: this means the metric changes over time
One important difference about time series data is that time is not just a metric (like the piece of data being collected), but rather it is the primary axis. This means that each numeric data point is paired with a timestamp and one or more labeled dimensions associated with the metric. It should be noted that the time intervals between each data point are most often gathered at regular intervals, although they can also be irregular.

Time series also consists of 4 main components:

Level: this refers to the average, baseline value of a time series as if it were a straight line
Trends: this means that variations in the data move up or down in trends or reasonably predictable patterns.
Seasonality: this means that there are seasonal variations that repeat over a specific time period, for example, each day, week, month, or year.
Variability: also known as “noise” or “volatility” ”,this refers to random variations that don’t fall into any of the other three categories.
The Different Types of Time Series Metrics
Now that we have a high-level definition, let’s look at a few of the different types of time series metrics.

"
