https://www.mongodb.com/docs/kubernetes-operator/master/reference/k8s-operator-specification/#spec.members


https://www.mongodb.com/docs/kubernetes-operator/master/

You provide the Operator with the specifications for your MongoDB cluster. The Operator uses this information to tell Kubernetes how to configure that cluster including provisioning storage, setting up the network connections, and configuring other resources.

 ![mongodb operator](https://www.mongodb.com/docs/kubernetes-operator/master/_images/kubernetes-operator.bakedsvg.svg)

 https://www.mongodb.com/docs/kubernetes-operator/master/tutorial/plan-k8s-op-architecture/#k8s-architecture

# mongodb database architecture
https://www.mongodb.com/docs/kubernetes-operator/master/tutorial/mdb-resources-arch/#mdb-resources-arch

The Kubernetes Operator uses Cloud Manager or Ops Manager to manage the following MongoDB database custom resources:

MongoDB
MongoDBUser

Your custom resource specifications define these resources in the Kubernetes Operator. The Kubernetes Operator monitors these resources. When you update the resource’s specification, the Kubernetes Operator pushes these changes to Cloud Manager or Ops Manager, which make changes to the MongoDB deployment’s configuration.

# edit resources
kubectl edit mongodbcommunity.mongodbcommunity.mongodb.com example-mongodb -n mongo

