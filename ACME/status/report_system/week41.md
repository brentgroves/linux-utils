# Topics

- K8s Operators and Dashboard
- Observability, and Metrics

## MySQL Operator

Wow this K8s operator does so much work I can hardly believe it!  Now that we have seemingling production ready dynamic storage I couldn't imagine not using it.  

It's managed by Oracle and is around 2 years old.  I think the distinctions between SQL and NoSQL databases are becoming more hard to find.  It looks like MongoDB uses MySQL and a flattened version of it's JSON objects to give the capability to write SQL queries and it looks like SQL database provide scalability and HA.

**[Here is a recent video describing it](https://www.google.com/search?q=mysql+operator+for+kubernetes+tutorial&oq=mysql+operator+for+kubernetes+tutorial&gs_lcrp=EgZjaHJvbWUyBggAEEUYOdIBCTM0MTExajBqN6gCALACAA&sourceid=chrome&ie=UTF-8#fpstate=ive&vld=cid:cfbd3f26,vid:LRvHmsWtOm4,st:0)**

**![MySQL Operator Architecture](https://dev.mysql.com/doc/mysql-operator/en/images/mysql-operator-architecture.png)**

### Controllers vs Operators

**[MySQL Operator](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-introduction.html)**

Kubernetes system uses Controllers to manage the life-cycle of containerized workloads. Controllers are general-purpose tools that provide capabilities for a broad range of services, but complex services require additional components and this includes operators.

An Operator is software running inside the Kubernetes cluster, and the operator interacts with the Kubernetes API to observe resources and services to assist Kubernetes with the life-cycle management.

The last time I deployed MySQL to Kubernetes I used a standard k8s object the stateful-set and Mayastor EBS storage to achieve Hi Availability. The standard Kubernetes controller managed the life-cycle of the stateful-set.  This time I found a Kubernetes Operator to deploy the MySQL InnoDB Cluster which achieves HA by using MaSQL group replication instead of relying on dynamic storage.

**[InnoDB Storage](https://dev.mysql.com/doc/refman/8.0/en/innodb-storage-engine.html>)**

InnoDB is a general-purpose storage engine that balances high reliability and high performance. In MySQL 8.0, InnoDB is the default MySQL storage engine. Unless you have configured a different default storage engine, issuing a CREATE TABLE statement without an ENGINE clause creates an InnoDB table.

Key Advantages of InnoDB
Its DML operations follow the ACID model, with transactions featuring commit, rollback, and crash-recovery capabilities to protect user data. See Section 15.2, “InnoDB and the ACID Model”.

Row-level locking and Oracle-style consistent reads increase multi-user concurrency and performance. See Section 15.7, “InnoDB Locking and Transaction Model”.

InnoDB tables arrange your data on disk to optimize queries based on primary keys. Each InnoDB table has a primary key index called the clustered index that organizes the data to minimize I/O for primary key lookups. See Section 15.6.2.1, “Clustered and Secondary Indexes”.

To maintain data integrity, InnoDB supports FOREIGN KEY constraints. With foreign keys, inserts, updates, and deletes are checked to ensure they do not result in inconsistencies across related tables. See Section 13.1.20.5, “FOREIGN KEY Constraints”.

**[MySQL InnoDB Cluster](https://dev.mysql.com/doc/refman/8.0/en/mysql-innodb-cluster-introduction.html)**
**![InnoDB Cluster](https://dev.mysql.com/doc/refman/8.0/en/images/innodb_cluster_overview.png)**
"An InnoDB Cluster consists of at least three MySQL Server instances, and it provides high-availability and scaling features. InnoDB Cluster uses the following MySQL technologies:

MySQL Shell, which is an advanced client and code editor for MySQL.  It has JavaScript, Python, or SQL mode depending on what you want to do.

MySQL Server, and Group Replication, which enables a set of MySQL instances to provide high-availability. InnoDB Cluster provides an alternative, easy to use programmatic way to work with Group Replication.

MySQL Router, a lightweight middleware that provides transparent routing between your application and InnoDB Cluster.

InnoDB Cluster supports MySQL Clone, which enables you to provision instances simply. In the past, to provision a new instance before it joins a set of MySQL instances you would need to somehow manually transfer the transactions to the joining instance. This could involve making file copies, manually copying them, and so on. Using InnoDB Cluster, you can simply add an instance to the cluster and it is automatically provisioned.

"
**[MySQL Clone](https://dev.mysql.com/doc/refman/8.0/en/clone-plugin.html)**

The clone plugin, introduced in MySQL 8.0.17, permits cloning data locally or from a remote MySQL server instance. Cloned data is a physical snapshot of data stored in InnoDB that includes schemas, tables, tablespaces, and data dictionary metadata. The cloned data comprises a fully functional data directory, which permits using the clone plugin for MySQL server provisioning.

**![Local Clone](https://dev.mysql.com/doc/refman/8.0/en/images/clone-local.png)**

A local cloning operation clones data from the MySQL server instance where the cloning operation is initiated to a directory on the same server or node where MySQL server instance runs.

**![Remote Clone](https://dev.mysql.com/doc/refman/8.0/en/images/clone-remote.png)**

A remote cloning operation involves a local MySQL server instance (the “recipient”) where the cloning operation is initiated, and a remote MySQL server instance (the “donor”) where the source data is located. When a remote cloning operation is initiated on the recipient, cloned data is transferred over the network from the donor to the recipient. By default, a remote cloning operation removes existing user-created data (schemas, tables, tablespaces) and binary logs from the recipient data directory before cloning data from the donor. Optionally, you can clone data to a different directory on the recipient to avoid removing data from the current recipient data directory.

**[Group Replication](https://dev.mysql.com/doc/refman/8.0/en/group-replication.html)**
This chapter explains MySQL Group Replication and how to install, configure and monitor groups. MySQL Group Replication enables you to create elastic, highly-available, fault-tolerant replication topologies.

Groups can operate in a single-primary mode with automatic primary election, where only one server accepts updates at a time. Alternatively, groups can be deployed in multi-primary mode, where all servers can accept updates, even if they are issued concurrently.

There is a built-in group membership service that keeps the view of the group consistent and available for all servers at any given point in time. Servers can leave and join the group and the view is updated accordingly. Sometimes servers can leave the group unexpectedly, in which case the failure detection mechanism detects this and notifies the group that the view has changed. This is all automatic.

Group Replication guarantees that the database service is continuously available. However, it is important to understand that if one of the group members becomes unavailable, the clients connected to that group member must be redirected, or failed over, to a different server in the group, using a connector, load balancer, router, or some form of middleware.

## What is K9s

**[What is K9s](https://k9scli.io/)**

Who Let The Pods Out?
K9s is a terminal based UI to interact with your Kubernetes clusters. The aim of this project is to make it easier to navigate, observe and manage your deployed applications in the wild. K9s continually watches Kubernetes for changes and offers subsequent commands to interact with your observed resources.

## What is observability

We are a manufacturing business but IT has it's own set of metrics.

I was thinking of WiFi uptime.  What else?

**[What is observability](https://www.strongdm.com/observability)

"
Observability is defined as a measure of how well the internal states of a system can be inferred from knowledge of its external outputs. When used in the IT context and with reference to the work of software development (Dev) and IT operations (Ops) teams, the term observability describes the ability to understand and manage the performance of all the systems, servers, applications, and other resources constituting an enterprise technology stack.

Observability is achieved via a combination of observability tools and methodologies—the observability platform—adopted specifically to enable DevOps teams to discover, triage, and resolve systems issues that threaten uptime and reliability and undermine the achievement of enterprise goals.

More simply, observability is distinct from monitoring, which passively tracks pre-defined metrics in discrete systems. Instead, observability makes actionable use of data by enabling a holistic view across the entirety of a technology stack. And it aggregates all the data produced by all the IT systems to produce real-time insights, identify anomalies, determine their root cause, and proactively resolve them
"

## What are Time Series Metrics?

**[Time Series Metrics](https://www.anodot.com/learning-center/time-series-metrics/#:~:text=What%20are%20Time%20Series%20Metrics,at%20each%20increment%20of%20time.)**
"
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

**[Prometheus](https://prometheus.io/docs/tutorials/getting_started/)**

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

## MicroK8s Observability

**[microK8s Observability](https://betterprogramming.pub/observability-with-microk8s-14c1f0ff5183)**

Microk8s has an observability stack built-in.

## How to collect data for metrics

An OPC or UDP client can be used to collect an individual record of a database table or an OPC point name, value, quality and timestamp from an OPC or Moxa serial device server and insert them into a database. This database can be used by analytics software such as Graphana or a custom Web SPA.

What is Grafana:
**[Grafana](https://grafana.com/)** is a multi-platform open source analytics and interactive visualization web application. It provides charts, graphs, and alerts for the web when connected to supported data sources

Data points:

- tool cut start and end times
- tool counter
- press data

What kind of PLC or CNC data point can you think of that would be a useful metric?

Usage:

- To collect, monitor, and analyze data to identify operational issues

- To create data point timeline graphs viewable in dashboards that can be used by managers to evaluate and compare performance by date, machine, person, etc.

Question:
