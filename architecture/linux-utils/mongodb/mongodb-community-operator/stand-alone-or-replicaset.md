![standalone-or-replicaset](https://www.mongodb.com/docs/kubernetes-operator/master/tutorial/mdb-resources-arch/#mdb-resources-arch)

In Kubernetes, a Standalone resource is equivalent to a ReplicaSet resource with only one member. We recommend that you deploy a ReplicaSet with one member instead of a Standalone because a replica set allows you to add members to it in the future.