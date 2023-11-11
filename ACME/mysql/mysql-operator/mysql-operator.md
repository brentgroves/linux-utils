# MySQL Operator

**![MySQL Operator Architecture](https://dev.mysql.com/doc/mysql-operator/en/images/mysql-operator-architecture.png)**

## Controllers vs Operators

Kubernetes system uses Controllers to manage the life-cycle of containerized workloads. Controllers are general-purpose tools that provide capabilities for a broad range of services, but complex services require additional components and this includes operators.

An Operator is software running inside the Kubernetes cluster, and the operator interacts with the Kubernetes API to observe resources and services to assist Kubernetes with the life-cycle management.

The last time I deployed MySQL to Kubernetes I used a standard k8s object the stateful-set and Mayastor EBS storage to achieve Hi Availability. The standard Kubernetes controller managed the life-cycle of the stateful-set.  This time I found a Kubernetes Operator to deploy the MySQL InnoDB Cluster which achieves HA by using MaSQL group replication instead of relying on dynamic storage.

**[MySQL Operator](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-introduction.html)

Chapter 1 Introduction
MySQL and Kubernetes share terminology. For example, a Node might be a Kubernetes Node or a MySQL Node, a Cluster might be a MySQL InnoDB Cluster or Kubernetes Cluster, and a ReplicaSet is a feature in both MySQL and Kubernetes. This documentation prefers the long names but these overloaded terms may still lead to confusion; context is important.

"Kubernetes
The Kubernetes system uses Controllers to manage the life-cycle of containerized workloads by running them as Pods in the Kubernetes system. Controllers are general-purpose tools that provide capabilities for a broad range of services, but complex services require additional components and this includes operators. An Operator is software running inside the Kubernetes cluster, and the operator interacts with the Kubernetes API to observe resources and services to assist Kubernetes with the life-cycle management."

MySQL Operator for Kubernetes
The MySQL Operator for Kubernetes is an operator focused on managing one or more MySQL InnoDB Clusters consisting of a group of MySQL Servers and MySQL Routers. The MySQL Operator itself runs in a Kubernetes cluster and is controlled by a Kubernetes Deployment to ensure that the MySQL Operator remains available and running.

The MySQL Operator is deployed in the 'mysql-operator' Kubernetes namespace by default; and watches all InnoDB Clusters and related resources in the Kubernetes cluster. To perform these tasks, the operator subscribes to the Kubernetes API server to update events and connects to the managed MySQL Server instance as needed. On top of the Kubernetes controllers, the operator configures the MySQL servers, replication using MySQL Group Replication, and MySQL Router.

Being built on MySQL Group Replication, provides features such as automatic membership management, fault tolerance, automatic failover, and so on. An InnoDB Cluster usually runs in a single-primary mode, with one primary instance (read-write) and multiple secondary instances (read-only). Advanced users can also take advantage of a multi-primary mode, where all instances are primaries. You can even change the topology of the cluster while InnoDB Cluster is online, to ensure the highest possible availability.

You work with InnoDB Cluster using the AdminAPI, provided as part of MySQL Shell. AdminAPI is available in JavaScript and Python, and is well suited to scripting and automation of deployments of MySQL to achieve high-availability and scalability. By using MySQL Shell's AdminAPI, you can avoid the need to configure many instances manually. Instead, AdminAPI provides an effective modern interface to sets of MySQL instances and enables you to provision, administer, and monitor your deployment from one central tool.

To get started with InnoDB Cluster you need to download and install MySQL Shell. You need some hosts with MySQL Server instances installed, and you can also install MySQL Router.

## MySQL InnoDB Cluster

Once an InnoDB Cluster (InnoDBCluster) resource is deployed to the Kubernetes API Server, MySQL Operator for Kubernetes creates resources including:

A Kubernetes StatefulSet for the MySQL Server instances.

This manages the Pods and assigns the corresponding storage Volume. Each Pod managed by this StatefulSet runs multiple containers. Several provide a sequence of initialisation steps for preparing the MySQL Server configuration and data directory, and then two containers remain active for operational mode. One of those containers (named 'mysql') runs the MySQL Server itself, and the other (named 'sidecar') is a Kubernetes sidecar responsible for local management of the node in coordination with the operator itself.

A Kubernetes Deployment for the MySQL Routers.

MySQL Routers are stateless services routing the application to the current Primary or a Replica, depending on the application's choice. The operator can scale the number of routers up or down as required by the Cluster's workload.

A MySQL InnoDB Cluster deployment creates these Kubernetes Services:

One service is the name of the InnoDB Cluster. It serves as primary entry point for an application and sends incoming connections to the MySQL Router. They provide stable name in the form '{clustername}.svc.cluster.local' and expose specific ports.

See also Section 3.4, “MySQL InnoDB Cluster Service Explanation” and Chapter 5, Connecting to MySQL InnoDB Cluster.

A second service named '{clustername}-instances' provides stable names to the individual servers. Typically these should not be directly used; instead use the main service to reliably reach the current primary or secondary as needed. However, for maintenance or monitoring purposes, direct access to an instance might be needed. Each pod instance has MySQL Shell installed.

MySQL Operator for Kubernetes creates and manages additional resources that should not be manually modified, including:

A Kubernetes ConfigMap named '{clustername}-initconf' that contains configuration information for the MySQL Servers.

To modify the generated my.cnf configuration file, see Section 3.3, “Manifest Changes for InnoDBCluster”.

A sequence of Kubernetes Secrets with credentials for different parts of the system; names include '{clustername}.backup', '{clustername.privsecrets}', and '{clustername.router}'.

For a list of MySQL accounts (and associated Secrets) created by the operator, see Section 3.5, “MySQL Accounts Created by InnoDBCluster Deployment”.

**[InnoDB Storage](https://dev.mysql.com/doc/refman/8.0/en/innodb-storage-engine.html>)**

InnoDB is a general-purpose storage engine that balances high reliability and high performance. In MySQL 8.0, InnoDB is the default MySQL storage engine. Unless you have configured a different default storage engine, issuing a CREATE TABLE statement without an ENGINE clause creates an InnoDB table.

**[MySQL InnoDB Cluster](https://dev.mysql.com/doc/refman/8.0/en/mysql-innodb-cluster-introduction.html)**

**![InnoDB Cluster](https://dev.mysql.com/doc/refman/8.0/en/images/innodb_cluster_overview.png)**

"An InnoDB Cluster consists of at least three MySQL Server instances, and it provides high-availability and scaling features. InnoDB Cluster uses the following MySQL technologies:

MySQL Shell, which is an advanced client and code editor for MySQL.

MySQL Server, and Group Replication, which enables a set of MySQL instances to provide high-availability. InnoDB Cluster provides an alternative, easy to use programmatic way to work with Group Replication.

MySQL Router, a lightweight middleware that provides transparent routing between your application and InnoDB Cluster.

Being built on MySQL Group Replication, provides features such as automatic membership management, fault tolerance, automatic failover, and so on. An InnoDB Cluster usually runs in a single-primary mode, with one primary instance (read-write) and multiple secondary instances (read-only). Advanced users can also take advantage of a multi-primary mode, where all instances are primaries. You can even change the topology of the cluster while InnoDB Cluster is online, to ensure the highest possible availability.

You work with InnoDB Cluster using the AdminAPI, provided as part of MySQL Shell. AdminAPI is available in JavaScript and Python, and is well suited to scripting and automation of deployments of MySQL to achieve high-availability and scalability. By using MySQL Shell's AdminAPI, you can avoid the need to configure many instances manually. Instead, AdminAPI provides an effective modern interface to sets of MySQL instances and enables you to provision, administer, and monitor your deployment from one central tool.

To get started with InnoDB Cluster you need to download and install MySQL Shell. You need some hosts with MySQL Server instances installed, and you can also install MySQL Router.
"
