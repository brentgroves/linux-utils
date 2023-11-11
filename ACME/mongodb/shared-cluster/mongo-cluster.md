https://www.opcito.com/blogs/ways-to-host-a-mongodb-cluster-on-kubernetes
https://www.opcito.com/blogs/ways-to-host-a-mongodb-cluster-on-kubernetes
1. Using Community Kubernetes Operator
Kubernetes Operator provides an interface to manage third-party applications just like Kubernetes-native objects. MongoDB Kubernetes Operator helps in creating, configuring, and managing MongoDB StatefulSet. The MongoDB Operators are of two types viz., MongoDB Community Operator and MongoDB Enterprise Kubernetes Operator. Both possess different sets of features and requirements. Let’s look at the steps to set up a cluster using the Community Kubernetes Operator.

![Cummunity Kubernetes Operator](https://www.opcito.com/hs-fs/hubfs/mongodb1.jpg?width=480&name=mongodb1.jpg)

Install the Community Kubernetes Operator
Clone this repository:

git clone https://github.com/mongodb/mongodb-kubernetes-operator.git 
Run the following command to create cluster-wide roles and role-bindings in the default namespace:

kubectl apply -f deploy/clusterwide 

https://www.mongodb.com/basics/clusters#:~:text=A%20sharded%20cluster%20in%20MongoDB,data%20and%20high%20query%20rates.

MongoDb Shared Cluster:
- Create 1 replica set on each node of the k8s cluster.
- Load balancer directs traffic to one of the nodes.
- Each node has a Mongs query compoent.
- Mongos routes the query to node where the data is and performs load balancing.
- If some nodes our down the Mongos component will redirect to one of the other nodes.

What is a Sharded Cluster?
A sharded cluster in MongoDB is a collection of datasets distributed across many shards (servers) in order to achieve horizontal scalability and better performance in read and write operations.


sharded clusters in mongodb

Sharding is very useful for collections that have a lot of data and high query rates.

![Shard A](https://webimages.mongodb.com/_com_assets/cms/kkh4ow57g54wpvn1t-mongodb-sharded-cluster.png?auto=format%2Ccompress)

Based on the above diagram, Collection1 is sharded, unlike Collection2, which is not sharded. If we kept Collection1 in one server, the CPU of that server could spike because it wouldn't have the necessary capacity to deal with the requests it received. However, adding another shard for Collection1 helps distribute the load by increasing the overall capacity that it can receive.

Configuring a sharded cluster allows a shard to also be configured as a replica set. In other words, it is configured to be with high availability and horizontal scalability. In addition, a component called mongos is deployed when configuring a sharded cluster. Mongos is a query router; it acts as an intermediary between the client and the server, or the shard that the data resides in. Apart from routing, it can also handle load balancing for all query and write operations to the shards.

Production Environment
Planning for disaster recovery and zero downtime means having a replica set of the MongoDB cluster across a single region or a number of regions, depending on how crucial the assessment of the risk is.

A replica set consists of the primary mongod process and other secondary processes. It is recommended that the total number of these processes is odd so that majority is ensured in the case that the master fails and a new master needs to be allocated.

Sharding a MongoDB cluster is also at the cornerstone of deploying a production cluster with huge data loads.

Obviously, designing your data models, appropriately storing them in collections, and defining corrected indexes is essential. But if you truly want to leverage the power of MongoDB, you need to have a plan regarding sharding your cluster.


