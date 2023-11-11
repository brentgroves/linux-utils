# Next

Just finished nodeport.yaml and mysql-operator-connecting.md and studying <https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-introduction.html>
so go to the next section at <https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-installation.html> and update mysql-operator.md

Good morning dear ones,
I hope you and your loved ones are staying warm today.  We already tested out our furnance and put on the extra blanket :-)  As always please feel free to contact me anytime at work or home for whatever!

-Sincerely yours,
Brent
260-564-4868

## Report System deployment

Held the first report system deployment meeting getting IT support to manage its K8s cluster.  Brenden will be setting up this K8s cluster on a newer version of Utanics.  It should be pretty nice!

## MySQL Operator

Wow this K8s operator does so much work I can hardly believe it!  Now that we have seemingling production ready dynamic storage I couldn't imagine not using it.  

It's managed by Oracle and is around 2 years old.  I think the distinctions between SQL and NoSQL databases are becoming more hard to find.  It looks like MongoDB uses MySQL and a flattened version of it's JSON type objects to give the capability to write SQL queries and it looks like SQL database provide scalability and HA.

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

## MongoDB Operator

Other databases are catching up by creating K8s operators to manage deployment and achieve HA scalability. IMO it's ability to scale and manage huge data sets were a few of the reasons for the popularity of these NoSQL databases.  Now they have added SQL query capability in a sort of hybrid environment relying on MySQL to perform SQL queries on flattenend data sets.

## Open EBS Mayastor dynamic storage

Without production quality dynamic storage non-Cloud-Provider K8s installs were not able to use these advanced operator installs of products such MongoDB.  Open EBS Mayastor seems ready now for production workloads but there is another called Ceph that can achieve this also.  I chose Open EBS Mayastor over Ceph because it is at version 2 where Ceph just came out recently in Kubernetes version 1.28.  Ceph runs and is managed outside of Kubernetes in its own Cluster and relies on a plug-in to be used by K8s.  Running outside of K8s maybe an advantage in that it can be used to offer modern dynamic storage capabilites to non-K8s frameworks.
