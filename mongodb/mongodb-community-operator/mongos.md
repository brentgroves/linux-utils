https://www.mongodb.com/docs/manual/reference/program/mongos/#mongodb-binary-bin.mongos

Synopsis
For a sharded cluster, the 
mongos
 instances provide the interface between the client applications and the sharded cluster. The 
mongos
 instances route queries and write operations to the shards. From the perspective of the application, a 
mongos
 instance behaves identically to any other MongoDB instance.

Considerations
Never change the name of the 
mongos
 binary.

Starting in version 4.4, 
mongos
 can support hedged reads to minimize latencies.

MongoDB disables support for TLS 1.0 encryption on systems where TLS 1.1+ is available. For more details, see Disable TLS 1.0.

The 
mongos
 binary will crash when attempting to connect to mongod instances whose feature compatibility version (fCV) is greater than that of the 
mongos
. For example, you cannot connect a MongoDB 4.2 version 
mongos
 to a 6.0 sharded cluster with fCV set to 6.0. You can, however, connect a MongoDB 4.2 version 
mongos
 to a 6.0 sharded cluster with fCV set to 4.2.



https://www.mongodb.com/docs/kubernetes-operator/master/reference/k8s-operator-specification/